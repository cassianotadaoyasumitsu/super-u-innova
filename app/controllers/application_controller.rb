class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  set_current_tenant_through_filter
  before_action :set_current_tenant

  protected

  # Você pode manter esse método caso algum outro Devise controller ainda precise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [company_attributes: [:name]])
  end

  private

def set_current_tenant
  subdomain = request.subdomain

  return if subdomain.blank? || subdomain == 'www'

  company = Company.find_by(subdomain: subdomain)

  if company
    ActsAsTenant.current_tenant = company
    Rails.logger.info "✅ Tenant set to #{company.name}"
  else
    Rails.logger.warn "⚠️ Subdomínio não encontrado: #{subdomain}"
    redirect_to "https://www.seusite.com", alert: "Empresa não encontrada", allow_other_host: true
  end
end

  
end
