class Users::RegistrationsController < Devise::RegistrationsController
    def new
      build_resource({})
      respond_with resource
    end
  
    def create
      build_resource(sign_up_params)
      resource.company = ActsAsTenant.current_tenant
      puts "💬 Current Tenant: #{ActsAsTenant.current_tenant&.name}"
      puts "💬 Company assigned to resource: #{resource.company&.name}"

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end
  