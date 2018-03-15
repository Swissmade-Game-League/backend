class UsersController < ApplicationController
  before_action :user_must_exist, except: [:index, :create]

  def index
    users = User.all
    render json: users
  end

  def show
    render json: @user
  end

  def create
  end

  def update
  end

  def destroy
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

end
