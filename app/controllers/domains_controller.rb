class DomainsController < ApplicationController
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :is_admin?

  def index
    @domains = Domain.order(:name)
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    @domain.user_ids = params[:domain] ? params[:domain][:user_ids] : nil
    @domain.save
    if @domain.valid?
      flash[:notice] = "Updated"
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  protected
    def is_admin?
      redirect_to root_path unless current_user.admin?
    end

end
