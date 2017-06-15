class LikesController < ApplicationController
  before_action :require_login
  # Thinking back to our models, we know that every instance of our Like and Secret Model
  # belongs to a User. When we create an instance of a Secret or a Like, we use the id
  # stored in session to find our User and then pass that User's id to the create method.
  # If a secret is created when nobody is signed in, that secret would not belong to
  # anybody because we do not have anyone in session.
  #
  # The same goes for all of the methods in the Secret's and Like's controller.
  # For example, it would horrible if anyone could see all of our users secrets
  # without logging in.

  def create
    Like.create like_params
    redirect_to "/secrets"
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy if current_user === @like.user
    redirect_to "/secrets"
  else
    redirect_to "/sessions/new"
  end

  private
  def like_params
    params.require(:like).permit(:secret_id).merge(user: current_user)
  end
end
