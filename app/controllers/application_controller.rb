# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  helper_method :current_user  
   
  def login_required
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
      
  def is_admin
	current_user.has_role?('admin')
  end

  private  
    def current_user_session  
      return @current_user_session if defined?(@current_user_session)  
      @current_user_session = UserSession.find  
    end  
      
    def current_user  
      @current_user = current_user_session && current_user_session.record  
    end  

    def store_location
      session[:return_to] = request.env["HTTP_REFERER"] || request.request_uri
    end
    
end
