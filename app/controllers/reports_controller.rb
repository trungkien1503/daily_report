class ReportsController < ApplicationController
  before_filter :signed_in_user
  def new
    @report = Report.new
    @catalogs_collection = Catalog.all.prepend(Catalog.new)
  end
  def create
    
  end
end
