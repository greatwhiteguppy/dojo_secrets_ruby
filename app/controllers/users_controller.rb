class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  # Any user should be able to register, so we won't need authentication for the
  # new and create methods.
  # However, if the User is not signed-in, they shouldn't be able to view,
  # edit or delete a User's profile.
  # So we will be restricting access to all of the methods except for new and create.
  def new
    #showing the registration page
  end

  def show
    # Sammi is user 20 and she's trying to get to Todd's page which is /user/21
    @user = User.find(params[:id]) # Todd's info
    if @user != :current_user #redirect
       #your user page
      redirect_to "/users/#{current_user.id}"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome"
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != :current_user
      redirect_to "/users/#{current_user.id}"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != :current_user
      redirect_to "/users/#{current_user.id}"
    elsif @user = :current_user
      @user.update user_params
    if @user.valid?
        @user.save
        redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user != :current_user
      redirect_to "/users/#{current_user.id}"
    elsif @user = :current_user && @user.destroy #check this on the platform with a new user to make sure it still works
      reset_session #need to reset session so we don't have problems w/finding id
      redirect_to "/users/new"
    else
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
