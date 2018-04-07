class AddressesController < ApplicationController
  before_action :address_must_exist, except: [:get_valid_addr]

  def show
    #render :json => @address
    payload = {
      message: "Temporarily disabled, brb soon",
      status: 503
    }
    render :json => payload, :status => payload[:status]
  end

  def get_valid_addr
    data = JT::Rails::Address.search(params["query"], Rails.application.secrets.google_maps_api_key)
    if !data
      data = {}
    end
    render json: data
  end

  private

  def address_must_exist
    @address = Address.find_by(id: params[:id])
    if !@address
      payload = {
        message: "Address not found",
        status: 404
      }
      render :json => payload, :status => payload[:status]
    end
  end
end
