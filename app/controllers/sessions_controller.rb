class SessionsController < ApplicationController
    def new
        # render login page
    end
    def create
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
      session.delete :user_id
      redirect_to "/sessions/new"
    end
end
