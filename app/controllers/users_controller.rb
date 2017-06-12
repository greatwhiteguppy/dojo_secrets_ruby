class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
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
  end

  def update
    @user = User.find(params[:id])
    @user.update user_params
    if @user.valid?
        @user.save
        redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
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
