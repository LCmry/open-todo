require 'spec_helper'

describe Api::ListsController do 

  before do
    List.destroy_all
  end

  describe "create" do
    context "with correct user's password" do
      it "takes a list name, creates it if it doesn't exist, and returns false if it does" do
        user = create(:user)
        params = { 'list' => {'user_id' => user.id, 'name' => 'newlist', 'permissions' => 'private'} }

        post :create, params
        response.should be_true

        post :create, params
        response.should be_false
      end
    end

    context "without correct user's password" do
      xit "it errors"
    end
  end

  describe "index" do
    context "with correct user's password" do
      xit "returns all lists associated with the user"
    end

    context "without correct user's password" do
      xit "returns all visible and open lists"
    end
  end
end