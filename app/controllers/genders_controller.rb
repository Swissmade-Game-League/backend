class GendersController < ApplicationController
  before_action :gender_must_exist, except: [:index]

  def index
    genders = Gender.all
    render json: genders
  end

  def show
    render :json => @gender
  end

  def get_gender_by_name
    render :json => @gender
  end

  def gender_must_exist
    @gender = Gender.find_by(id: params[:id]) || Gender.find_by(name: params[:name])
    if !@gender
      payload = {
        message: "Gender not found",
        status: 404
      }
      render :json => payload, :status => 404
    end
  end

  private

  def gender_params
    params.require(:gender).permit(:name)
  end

end
