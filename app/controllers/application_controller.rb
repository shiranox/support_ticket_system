class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def authenticate_manager!
        unless logged_in? && current_user.manager?
            redirect_to root_path, alert: "Only managers can access this page."
        end
    end

end
