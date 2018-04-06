class PaymentsController < ApplicationController
  before_action :user_must_exist, :user_must_be_authent

  def create
    payment = Payment.new
    payment.user = @user
    payment.amount = payment_params[:amount]
    if payment.save && payment.get_first_unassigned_product != nil
      if payment_params.has_key?(:stripeToken)
        begin
          customer = nil
          if !@user.remote_id
            mail=""
            if payment_params.has_key?(:stripeEmail)
              mail = payment_params[:stripeEmail]
            else
              mail = @user.mail
            end
            customer = Stripe::Customer.create(
              :email => mail,
              :source  => payment_params[:stripeToken],
              :metadata => {
                "firstname"=>@user.firstname.capitalize,
                "lastname"=>@user.lastname.capitalize,
                "nickname"=>@user.nickname,
              }
            )
            @user.password_confirmation = @user.password
            @user.remote_id = customer.id
            @user.save
          else
            customer = Stripe::Customer.retrieve(@user.remote_id)
            customer.email = @user.mail
            customer.metadata = {
              "firstname"=>@user.firstname.capitalize,
              "lastname"=>@user.lastname.capitalize,
              "nickname"=>@user.nickname,
            }
            customer.source = payment_params[:stripeToken]
            customer.save
          end
          payment.paid = true
          if payment.valid?
            charge = Stripe::Charge.create(
              :customer    => customer.id,
              :amount      => payment.amount.to_i*100,
              :description => payment.user.firstname.capitalize+" "+"''"+payment.user.nickname+"''"+" "+payment.user.lastname.capitalize,
              :currency    => 'chf',
              :metadata    => {
                "firstname" => payment.user.firstname.capitalize,
                "lastname" => payment.user.lastname.capitalize,
                "nickname" => payment.user.nickname,
              }
            )
          end
          if payment.save
            payload = {
              message: "You're payment has been validated",
              payment: payment.as_json,
              status: 200
            }
          else
            payment.product.payment = nil
            payload = {
              message: "Error during the payment process, "+payment.errors.full_messages.to_sentence,
              status: 400
            }
          end
        rescue Stripe::CardError => e
          if payment.product
            payment.product.payment = nil
          end
          payment.destroy
          payload = {
            message: e.message,
            status: 402
          }
        rescue => error
          if payment.product
            payment.product.payment = nil
          end
          payment.destroy
          payload = {
            message: "An error occurred while registering "+error.to_s,
            status: 500
          }
        end
      else
        payment.paid = false
        if payment.save
          payload = {
            message: "Thanks, your payment is waiting for validation. This process could take some days.",
            payment: payment.as_json,
            status: 200
          }
        else
          payload = {
            message: "Error during the payment process, "+payment.errors.full_messages.to_sentence,
            status: 400
          }
        end
      end
    else
      if payment.get_first_unassigned_product == nil
        payload = {
          message: "Product keys out of stock. Don't worry, you didn't paid anything. ",
          status: 400
        }
      else
        payload = {
          message: "An error occurred during the payment process. Don't worry, you didn't paid anything. "+payment.errors.full_messages.to_sentence,
          status: 400
        }
      end
    end
    render :json => payload, :status => payload[:status]
  end

  private

  def user_must_exist
    @user = User.find_by(id: payment_params[:user_id])
    if !@user
      payload = {
        message: "User not found",
        status: 404
      }
      render :json => payload, :status => 404
    end
  end

  def user_must_be_authent
    if @user && @user.token != payment_params[:user_token]
      payload = {
        message: "Wrong user's credentials, check the user's token using the authenticate method. If you updated a user, you need a new authentication.",
        status: 403
      }
      render :json => payload, :status => 403
    end
  end

  def payment_params
    params.require(:payment).permit(:user_id, :user_token, :amount, :stripeToken, :stripeEmail)
  end

end
