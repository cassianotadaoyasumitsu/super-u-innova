# app/controllers/companies_controller.rb
class CompaniesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_super_admin!
  
    def index
      @companies = Company.all
    end
  
    def new
      @company = Company.new
    end
  
    def create
      @company = Company.new(company_params)
      if @company.save
        redirect_to companies_path, notice: "Empresa criada com sucesso!"
      else
        render :new
      end
    end
  
    private
  
    def company_params
      params.require(:company).permit(:name, :subdomain)
    end
  
    def ensure_super_admin!
      redirect_to root_path, alert: "Acesso negado." unless current_user.super_admin?
    end
  end
  