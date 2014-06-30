class DomainsController < ApplicationController
  protect_from_forgery with: :exception, except: :create

  before_filter :authenticate_user!
  before_filter :is_admin?

  def index
    @domains = Domain.order(:name)
    @domain = Domain.new
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    @domain.user_ids = params[:domain] ? params[:domain][:user_ids] : nil
    @domain.save
    if @domain.valid?
      flash[:notice] = "Updated #{@domain.name}'s users to #{@domain.user_domains.map {|ud| ud.user.email}.join(', ')}"
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to domains_path, notice: 'Domain was successfully created.' }
        format.js   {}
        format.json { render json: @domain, status: :created, location: @domain }
      else
        format.html { redirect_to domains_path, notice: 'Could not save the domain.' }
        format.js   { render 'create_fail' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  protected
    def is_admin?
      redirect_to root_path unless current_user.admin?
    end

    def domain_params
      params.require(:domain).permit(:name)
    end
end
