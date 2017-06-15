require 'rails_helper'
RSpec.describe SecretsController, type: :controller do
  before do
    @user = create(:user)
    @secret = create(:secret, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, params: { id: @secret.id }
      expect(response).to redirect_to("/sessions/new")
    end
  context "when signed in as the wrong user" do
    it "cannot destroy another user's secret" do
      @user2 = User.create(name:"Walter", email:"woof@gmail.com", password:"woofwoof")
      session[:user_id] = @user2.id
      @secret2 = create(:secret, user: @user2)
      delete :destroy, params: {id: @secret.id}
      expect(response).to redirect_to("/users/#{@user2.id}")
      end
    end
  end
end
