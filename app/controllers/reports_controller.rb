class ReportsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :index]
  def new
    @report = Report.new
    @catalogs_collection = Catalog.all.prepend(Catalog.new)
  end

  def create
    @report = Report.new(params[:report]) do |t|
      if params[:report][:attached_file_data]
        t.attached_file_data = params[:report][:attached_file_data].read
        t.attached_file_name = params[:report][:attached_file_data].original_filename
        t.attached_file_type = params[:report][:attached_file_data].content_type
      end
    end
    if @report.save
      flash.now[:notice] = "create report success"
      redirect_to reports_path
    else
      flash.now[:error] = "create report failed"
      @catalogs_collection = Catalog.all.prepend(Catalog.new)
      render 'new'
    end
  end

  def index
    @user = current_user
    @report_collection = Report.find_by_user_id(@user.id)
  end
end
