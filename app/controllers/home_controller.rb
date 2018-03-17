class HomeController < ApplicationController
  def index
    payload = {
      name: "Swiss Game League",
      environment: Rails.env,
      version: {
        number: "1.0",
        build_hash: get_revision
      },
      tagline: "Grinding the ladder, You Know"
    }
    render json: payload
  end

  private

  def get_revision(length=1000)
    if File.exist?(Rails.root.join('REVISION'))
      return File.read(Rails.root.join('REVISION'))[0...length]
    else
      return "unknown 😳"
    end
  end

end
