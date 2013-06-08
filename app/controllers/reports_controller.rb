class ReportsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :index, :serve]
  def new
    @report = Report.new
    @catalogs_collection = Catalog.all.prepend(Catalog.new)
  end

  def create
    @report = Report.new(params[:report])
    if @report.save
      redirect_to reports_path
    else
      flash.now[:error] = "create report failed"
      @catalogs_collection = Catalog.all.prepend(Catalog.new)
      render 'new'
    end
  end

  def index
    @user = current_user
    @reports = @user.reports.where(created_at: Date.yesterday..Time.now.to_datetime).paginate(page: params[:page], per_page: 1)
  end
  def serve
    @report = Report.find(params[:id])
    if signed_in? and @report
      send_file @report.file.current_path 
    end
  end
end
