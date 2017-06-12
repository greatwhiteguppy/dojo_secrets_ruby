class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def create
    secret = Secret.new(secret_params)
    if secret.save
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to "/secrets"
    end
  end

  def destroy
    @secret = Secret.find(params[:id])
    if @secret.user == current_user
        @secret.destroy
        redirect_to "/users/#{current_user.id}"
      end
    end

  private
    def secret_params
      params.require(:secret).permit(:content).merge(user: current_user)
    end
end
