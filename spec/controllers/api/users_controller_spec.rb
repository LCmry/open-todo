# Using token authentication, not tested by this spec

require 'spec_helper'

describe Api::UsersController do

  before do
    User.destroy_all
  end

  describe "create" do
    it "creates and returns a new user from username and password params" do
      params = { 'user' => { 'username' => 'testuser', 'password' => 'testpass' } }

      expect{ post :create, params }
        .to change{ User.where(params['user']).count }
        .by 1

      JSON.parse(response.body).should == params['user']
    end

    it "returns an error when not given a password" do
      post :create, { user: {username: 'testuser'} }
      response.should be_false
    end

    it "returns an error when not given a username" do
      post :create, { user: {password: 'testpass'} }
      response.should be_false
    end
  end

  describe "index" do

    before do 
      (1..3).each{ |n| User.create( id: n, username: "name#{n}", password: "pass#{n}" ) }
    end

    it "lists all usernames and ids" do
      get :index

      JSON.parse(response.body).should == 
        { 'users' => 
          [
            { 'id' => 1, 'username' => 'name1' },
            { 'id' => 2, 'username' => 'name2' },
            { 'id' => 3, 'username' => 'name3' }
          ]
        }
    end
  end
end
