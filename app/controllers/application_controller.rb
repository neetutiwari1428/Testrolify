require 'devise'
class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    before_action :authenticate_user!, only: [:new, :update]
    protect_from_forgery with: :exception
    include Pundit#::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    after_action :verify_authorized, except: :index, unless: -> { devise_controller? }
    after_action :verify_policy_scoped, only: :index
    private
    def current_user
        true
    end
    class UserContext
        attr_reader :user, :ip
      
        def initialize(user, ip)
          @user = user
          @ip   = ip
        end
    end
    def pundit_user
        UserContext.new(current_user, request.ip)
    end
    private
    def user_not_authorized
        flash[:alert] = "You are not authorized to perform this action."
        redirect_back(fallback_location: root_path)
    end
    
    private
    def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back(fallback_url: root_path)
    end
    def skip_pundit?
        devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end
end
