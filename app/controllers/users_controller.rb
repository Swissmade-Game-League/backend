class UsersController < ApplicationController
  before_action :user_must_exist, except: [:index, :create]
  before_action :users_token_must_be_valid, only: [:update, :destroy]
  before_action :check_address, :check_locality, :check_state, :check_country, only: [:create]

  def index
    #users = User.all
    #render json: users, :except => [:password, :token, :salt]
    payload = {
      message: "Temporarily disabled, brb soon",
      status: 503
    }
    render :json => payload, :status => payload[:status]
  end

  def show
   render :json => @user , :except => [:password, :token, :salt]
  end

  def create
    @user = User.new(user_params.except(:gender_id, :address))
    @user.gender = Gender.find_by(id: user_params[:gender_id])
    country    = Country.find_or_initialize_by("name" => user_params[:address][:country][:name])
    state     = State.find_or_initialize_by("name" => user_params[:address][:state][:name], "country" => country)
    locality  = Locality.find_or_initialize_by(
                                                "name" =>user_params[:address][:locality][:name],
                                                "postal_code" => user_params[:address][:locality][:postal_code],
                                                "state" => state
                                              )
    address   = Address.find_or_initialize_by(
                                                "street" =>user_params[:address][:street],
                                                "number"=>user_params[:address][:number],
                                                "locality"=>locality
                                              )
    state.country = country
    locality.state = state
    address.locality = locality
    @user.address = address
    @user.gen_token_and_salt
    if country.save && state.save && locality.save && address.save && @user.save
      render json: @user, :except => [:password, :token, :salt]
    else
      payload = {
        message: "User not created, "+@user.errors.full_messages.to_sentence+locality.errors.full_messages.to_sentence+address.errors.full_messages.to_sentence+state.errors.full_messages.to_sentence+country.errors.full_messages.to_sentence,
        status: 400
      }
      render :json => payload, :status => payload[:status]
    end
  end

  def update
    old_mail = @user.mail
    if @user.update_attributes(user_params.except(:gender_id))
      if user_params.has_key?(:gender_id)
        @user.gender = Gender.find_by(id: user_params[:gender_id])
      end
      if user_params.has_key?(:password) && user_params.has_key?(:password_confirmation)
        @user.password = user_params["password"]
        @user.password_confirmation = user_params["password_confirmation"]
        @user.gen_token_and_salt
        @user.change_password(@user.password)
      else
        @user.password_confirmation = @user.password
      end
      if @user.save
        render json: @user, :except => [:password, :token, :salt]
      else
        payload = {
          message: "User not updated, "+@user.errors.full_messages.to_sentence,
          status: 400
        }
        render :json => payload, :status => payload[:status]
      end
    else
      payload = {
        message: "User not updated, "+@user.errors.full_messages.to_sentence,
        status: 400
      }
      render :json => payload, :status => payload[:status]
    end
  end

  def destroy
    if @user.destroy
      payload = {
        info: "User deleted",
        status: 200
      }
      render :json => payload, :status => payload[:status]
    else
      payload = {
        message: "User not updated, "+@user.errors.full_messages.to_sentence,
        status: 400
      }
      render :json => payload, :status => payload[:status]
    end
  end

  def authenticate
    mail = user_params[:mail]
    password = user_params[:password]
    user = User.find_by(mail: mail)
    if user && user.authenticate(password)
      render json: @user, :except => [:password, :salt]
    else
      payload = {
        message: "Wrong user's credentials",
        status: 400
      }
      render :json => payload, :status => payload[:status]
    end
  end

  private

  def user_must_exist
    @user = User.find_by(id: params[:id]) || (params.has_key?(:user) && User.find_by(mail: user_params[:mail]))
    if !@user
      payload = {
        message: "User not found",
        status: 404
      }
      render :json => payload, :status => payload[:status]
    end
  end

  def users_token_must_be_valid
    if @user && @user.token != user_params[:token]
      payload = {
        message: "Wrong user's credentials, check the user's token using the authenticate method. If you updated a user, you need a new authentication.",
        status: 403
      }
      render :json => payload, :status => payload[:status]
    end
  end

  def check_address
    if !user_params.has_key?(:address) || !user_params[:address].has_key?(:street)
       payload = {
         message: "missing or bad user's address",
         status: 400
       }
       render :json => payload, :status => payload[:status]
    end
  end

  def check_locality
    if !user_params.has_key?(:address) || !user_params[:address].has_key?(:locality) || !user_params[:address][:locality].has_key?(:name) || !user_params[:address][:locality].has_key?(:postal_code)
       payload = {
         message: "missing or bad user's address locality",
         status: 400
       }
       render :json => payload, :status => payload[:status]
    end
  end

  def check_state
    if !user_params.has_key?(:address) || !user_params[:address].has_key?(:state) || !user_params[:address][:state].has_key?(:name)
       payload = {
         message: "missing or bad user's address state",
         status: 400
       }
       render :json => payload, :status => payload[:status]
    end
  end

  def check_country
    if !user_params.has_key?(:address) || !user_params[:address].has_key?(:country) || !user_params[:address][:country].has_key?(:name)
       payload = {
         message: "missing or bad user's address country",
         status: 400
       }
       render :json => payload, :status => payload[:status]
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :nickname, :mail, :password, :password_confirmation, :birthdate, :token, :gender_id, :dev, :team_name, :address => [:street, :number, :locality => [:name, :postal_code], :state => [:name], :country => [:name]])
  end

end
