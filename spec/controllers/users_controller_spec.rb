require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, params: { id: @user.id }
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access edit" do
      get :edit, params: { id: @user.id }
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access update" do
      patch :update, params: { id: @user.id }
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, params: { id: @user.id }
      expect(response).to redirect_to("/sessions/new")
    end
  end
    context "when signed in as the wrong user" do
      it "cannot access profile page of another user" do
        @user2 = User.create(name:"Walter", email:"woof@gmail.com", password:"woofwoof")
        session[:user_id] = @user2.id
        get :show, params: { id: @user.id}
        expect(response).to redirect_to("/users/#{@user2.id}")
      end
      it "cannot access the edit page of another user" do
        @user2 = User.create(name:"Walter", email:"woof@gmail.com", password:"woofwoof")
        session[:user_id] = @user2.id
        get :edit, params: { id: @user.id}
        expect(response).to redirect_to("/users/#{@user2.id}")
      end
      it "cannot update another user" do
        @user2 = User.create(name:"Walter", email:"woof@gmail.com", password:"woofwoof")
        session[:user_id] = @user2.id
        patch :update, params: { id: @user.id }
        expect(response).to redirect_to("/users/#{@user2.id}")
      end
      it "cannot destroy another user" do
        @user2 = User.create(name:"Walter", email:"woof@gmail.com", password:"woofwoof")
        session[:user_id] = @user2.id
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to("/users/#{@user2.id}")
      end
    end

end
