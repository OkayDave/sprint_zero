class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  allow_browser versions: :modern

  helper_method :stripe_enabled?

  private

  def user_not_authorized
    flash[:alert] = "You are not authorised to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def record_not_found
    respond_to do |format|
      format.html { render file: Rails.root.join("public/404.html"), status: :not_found, layout: false }
      format.json { render json: { error: "The page you are looking for does not exist." }, status: :not_found }
    end
  end

  def stripe_enabled?
    @stripe_enabled ||= ENV.fetch("STRIPE_ENABLED", "false") == "true"
  end
end
