class SessionsController < ApplicationController
  before_action :require_login, except: [:new, :create]
  # If we were to restrict access to our new and create method, it would be impossible
  # for the User to sign-in.
  # However, if a User is not signed-in, there's no reason that User should be able
  # to sign-out.

    def new
        # render login page
    end
    def create
      #logging in
      @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to "/users/#{@user.id}"
        else
          flash[:errors] = ["Invalid Combination"]
          redirect_to "/sessions/new"
        end
    end

    def destroy
      #logging out
      session.delete :user_id
      redirect_to "/sessions/new"
    end
end
