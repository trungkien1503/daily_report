class CatalogsController < ApplicationController
  before_filter 'signed_in_user'
  def new
    @catalog = Catalog.new
  end

  def create
    respond_to do |format|
      format.html do
        if signed_in?
          @catalog = Catalog.new(params['catalog'])
          if @catalog.save
            flash.now['success'] = 'creation successful'
            redirect_to new_catalog_path
          else
            flash.now['error'] = 'creation failed'
            render :new
          end
        else
          render 'sessions/new'
        end
      end
      format.js { @catalog = Catalog.find(params['catalog']['id']) }
    end
  end

end
