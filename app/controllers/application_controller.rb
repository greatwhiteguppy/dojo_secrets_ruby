class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
  def require_login
   unless logged_in?
     flash[:error] = "You must be logged in to access this section"
     redirect_to "/sessions/new"
   end
 end

   def logged_in?
       current_user != nil
    end
end
