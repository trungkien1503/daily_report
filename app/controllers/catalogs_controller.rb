class CatalogsController < ApplicationController
  before_filter :signed_in_user
  def create
    @catalog = Catalog.find(params[:catalog][:id])
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

end
