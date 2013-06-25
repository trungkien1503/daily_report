class ReportsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :index, :serve]
  def new
    @report = Report.new
    @catalogs_collection = Catalog.all
  end

  def create
    @report = Report.new(params['report'])
    if @report.save
      redirect_to reports_path
    else
      flash.now['error'] = 'create report failed'
      @catalogs_collection = Catalog.all
      render :new
    end
  end

  def index
    @user = current_user
    @reports = @user.reports.where('created_at >= ?', DateTime.yesterday)
                    .paginate(page: params['page'], per_page: 1)
  end

  def serve
    @report = Report.find(params['id'])
    send_file @report.file.current_path if signed_in? && @report
  end
end
