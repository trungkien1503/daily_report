class UsersController < ApplicationController
  before_filter 'signed_in_user', only: [:edit, :update, :index, :create]
  before_filter 'correct_user',   only: [:edit, :update]
  def index
    @users = User.paginate(page: params['page'], per_page: 20)
  end

  def show
    if signed_in?
      @user = User.find(params['id'])
      @groups = Group.all
    else
      redirect_to root_path
    end
  end

  def new
    redirect_to root_path if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(params['user'])
    @user.password = @user.password_confirmation = User.auto_generate_password
    @user.activation_token = Digest::MD5::hexdigest(@user.email.downcase)
    @act = Activation.new(user_id: @user.id, activation_status: 'inactivated')
    if @user.save && @act.save
      mail_activate(@user)
      flash.now['message'] = 'signup success, check mail for password'
      render 'sessions/new'
    else
      flash.now['error'] = 'signup failed'
      render :new
    end
  end

  def edit
  end

  def update
    @user = User.find(params['id'])
    if @user.update_attributes(params['user'])
      flash['success'] = 'Profile updated'
      sign_in @user
      redirect_to @user
    else
      render :edit
    end
  end

  def activate
    @user = User.find_by_activation_token(params['id'])
    if @user
      User.activate(@user)
      flash.now['message'] = 'activation success'
    else
      flash.now['message'] = 'activation failed'
    end
    render 'static_pages/home'
  end

  def gen_reports
    @user = current_user
    @members = @user.group.users
  end

  def gen_reports_result
    @user = current_user
    @members = @user.group.users
    @type = params['type']
    @id = params['user_id'].to_i
    if params['type'] && params['user_id']
      @reports = User.find(@id).reports
      render :gen_reports
    else
      render :gen_reports
    end
  end

  def gen_excel
    @type = params['type']
    @id = params['user_id'].to_i
    @reports = User.find(@id).reports
    tmp = Tempfile.new('writeexcel')
    workbook = WriteExcel.new(tmp.path)
    worksheet  = workbook.add_worksheet
    format = workbook.add_format
    format.set_text_wrap
    mergedformat = workbook.add_format(
      border: 6,
      valign: 'vcenter',
      align: 'center')
    worksheet.write(0, 0, @type)
    header = Hash.new
    mark_row = Hash.new
    col = 0
    Catalog.all.each do |v|
      worksheet.write(0, col + 1, v.name, format)
      header[v.id] = col + 1
      mark_row[v.id] = 0
      col += 1
    end
    maxrow = 0
    case @type
    when 'week'
      @wreports = @reports.group_by(&:week)
    when 'month'
      @wreports = @reports.group_by(&:month)
    when 'year'
      @wreports = @reports.group_by(&:year)
    end
    @wreports.each do |week, wreport|
      wrow = maxrow
      while wreport.count > 0
        r = wreport.first
        col = header[r.catalog_id]
        data = r.content
        unless r.file.blank?
          data << "\n file: http://localhost:3000/reports/#{r.id}/serve"
        end
        worksheet.write(mark_row[r.catalog_id] + 1, col, data, format)
        mark_row[r.catalog_id] += 1
        maxrow = mark_row[r.catalog_id] if mark_row[r.catalog_id] > maxrow
        wreport.delete(r)
      end
      Catalog.all.each do |v|
        mark_row[v.id] = maxrow
      end
      if wrow + 1 < maxrow
      worksheet.merge_range(wrow + 1, 0, maxrow, 0, week, mergedformat)
      else
      worksheet.write(wrow + 1, 0, week, mergedformat)
      end
    end
    workbook.close
    tmp.read
    send_file(tmp.path, filename: "user#{@id}_by#{@type}.xls")
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def mail_activate(user)
    UserMailer.welcome_email(user).deliver
    UserMailer.active_email(user).deliver
  end
end
