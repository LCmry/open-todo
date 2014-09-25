require 'spec_helper'

describe Api::ListsController do 

  before do
    List.destroy_all
    User.destroy_all
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
      it "it errors" do
        user = create(:user, password: 'wrongpass')
        params = { 'list' => {'user_id' => user.id, 'name' => 'newlist', 'permissions' => 'private'} }

        post :create, params
        response.should be_false
      end
    end
  end

  describe "index" do
    context "with correct user's password" do
      it "returns all lists associated with the user" do
        user = create(:user)
        list = create(:list)

        get :index
        JSON.parse(response.body).should ==
        { 'lists' => 
          [
            { name: 'Shopping list', permissions: 'private' }
          ]
        }
      end
    end

    context "without correct user's password" do
      it "returns all visible and open lists" do
        user = create(:user, password: 'wrongpass')
        list = create(:list, user_id: user.id)
        list1 = create(:list, name: 'Open list', permissions: 'open')
        list2 = create(:list, name: 'Visible list', permissions: 'visible')

        get :index
        JSON.parse(response.body).should ==
        { 'lists' =>
          [
            { name: 'Open list', permissions: 'open' },
            { name: 'Visible list', permissions: 'visible' }
          ]
        }
      end
    end
  end
end