class UsersController < ApplicationController
  before_action :user_must_exist, except: [:index, :create]

  def index
    users = User.all
    render json: users, :except => [:password, :token, :salt]
  end

  def show
   render :json => @user , :except => [:password, :token, :salt]
  end

  def create
    @user = User.new(user_params)
    @user.gen_token_and_salt
    if @user.save
      render json: @user
    else
      payload = {
        error: "User not created, "+@user.errors.full_messages.to_sentence,
        status: 500
      }
      render :json => payload, :status => 500
    end
  end

  def update
    old_mail = @user.mail
    if @user.update_attributes(user_params)
      if user_params.has_key?(:password) && user_params.has_key?(:password_confirmation)
        @user.password = user_params["password"]
        @user.password_confirmation = user_params["password_confirmation"]
        @user.gen_token_and_salt
        @user.change_password(@user.password)
      else
        @user.password_confirmation = @user.password
      end
      if @user.save
        render json: @user
      else
        payload = {
          error: "User not updated, "+@user.errors.full_messages.to_sentence,
          status: 500
        }
        render :json => payload, :status => 500
      end
    else
      payload = {
        error: "User not updated, "+@user.errors.full_messages.to_sentence,
        status: 500
      }
      render :json => payload, :status => 500
    end
  end

  def destroy
    if @user.destroy
      payload = {
        error: "User deleted",
        status: 200
      }
      render :json => payload, :status => 200
    else
      payload = {
        error: "User not updated, "+@user.errors.full_messages.to_sentence,
        status: 500
      }
      render :json => payload, :status => 500
    end
  end

  def user_must_exist
    @user = User.find_by(id: params[:id])
    if !@user
      payload = {
        error: "User not found",
        status: 404
      }
      render :json => payload, :status => 404
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :mail, :password, :password_confirmation, :birthdate)
  end

end
