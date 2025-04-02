class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def user_not_authorized
    flash[:alert] = "You are not authorised to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
