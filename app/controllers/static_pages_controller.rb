class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def show
    @static_page = StaticPage.find(params[:id])

    authenticate_user! if @static_page.requires_sign_in
  end
end
