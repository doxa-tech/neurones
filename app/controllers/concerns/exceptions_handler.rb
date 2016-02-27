module ExceptionsHandler

  extend ActiveSupport::Concern

  included do

    rescue_from Adeia::AccessDenied do |exception|
      respond_to do |format|
        format.html do
          redirect_to root_path, error: "Vous n'êtes pas authorisé !"
        end
        format.all { render nothing: true, status: 403 }
      end
    end

    rescue_from Adeia::LoginRequired do |exception|
      respond_to do |format|
        format.html do
          redirect_to login_path, error: "Veuillez d'abord vous connecter."
          format.all { render nothing: true, status: 401 }
        end
      end
    end

  end

end
