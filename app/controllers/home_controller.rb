class HomeController < ApplicationController
  def index
    payload = {
      name: "Swiss Made Game League",
      environment: Rails.env,
      repo: "https://github.com/Swissmade-Game-League/backend",
      version: {
        number: "1.0",
        build_hash: get_revision
      },
      tagline: "Grinding the ladder, you know"
    }
    render json: payload
  end

  private

  def get_revision(length=1000)
    if File.exist?(Rails.root.join('REVISION'))
       revision = File.read(Rails.root.join('REVISION'))[0...length]
       return revision.tr('\n', '')
    else
      return "unknown 😳"
    end
  end

end
