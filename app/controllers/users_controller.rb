class UsersController < ApplicationController
  before_action :user_must_exist, except: [:index, :create]
  before_action :users_token_must_be_valid, only: [:update, :destroy]

  def index
    users = User.all
    render json: users, :except => [:password, :token, :salt]
  end

  def show
   render :json => @user , :except => [:password, :token, :salt]
  end

  def create
    @user = User.new(user_params.except(:gender))
    @user.gender = Gender.find_by(name: user_params[:gender])
    @user.gen_token_and_salt
    if @user.save
      render json: @user, :except => [:password, :token, :salt]
    else
      payload = {
        error: "User not created, "+@user.errors.full_messages.to_sentence,
        status: 400
      }
      render :json => payload, :status => 400
    end
  end

  def update
    old_mail = @user.mail
    if @user.update_attributes(user_params.except(:gender))
      if user_params.has_key?(:gender)
        @user.gender = Gender.find_by(name: user_params[:gender])
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
          error: "User not updated, "+@user.errors.full_messages.to_sentence,
          status: 400
        }
        render :json => payload, :status => 400
      end
    else
      payload = {
        error: "User not updated, "+@user.errors.full_messages.to_sentence,
        status: 400
      }
      render :json => payload, :status => 400
    end
  end

  def destroy
    if @user.destroy
      payload = {
        info: "User deleted",
        status: 200
      }
      render :json => payload, :status => 200
    else
      payload = {
        error: "User not updated, "+@user.errors.full_messages.to_sentence,
        status: 400
      }
      render :json => payload, :status => 400
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
        error: "Wrong user's credentials",
        status: 400
      }
      render :json => payload, :status => 400
    end
  end

  def user_must_exist
    @user = User.find_by(id: params[:id]) || User.find_by(mail: user_params[:mail])
    if !@user
      payload = {
        error: "User not found",
        status: 404
      }
      render :json => payload, :status => 404
    end
  end

  def users_token_must_be_valid
    if @user && @user.token != user_params[:token]
      payload = {
        error: "Wrong user's credentials, check the user's token using the authenticate method. If you updated a user, you need a new authentication.",
        status: 400
      }
      render :json => payload, :status => 400
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :mail, :password, :password_confirmation, :birthdate, :token, :gender)
  end

end
