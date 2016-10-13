require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(
      name: 'Jackie',
      email: 'jackie@example.com',
      password: 'password'
      )
  end

  describe "information is valid" do
    it "is valid with a name and email" do
      expect(@user).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
    it "is invalid without an email address" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    it "is invalid with a duplicate email address" do
      User.create(name: 'test', email: 'test@example.com', password: 'password')
      user = User.new(name: 'test', email: 'test@example.com', password: 'password')
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe "associations" do
    let(:user) { subject }

    it "has many foods through destinations" do
      food = Food.create

      user.foods << food
      user.save

      expect(food.users).to eq(user)
    end

    it "has many destinations" do
      destination = Destination.create

      user.destinations << destination
      user.save

      expect(destination.user).to eq(user)
    end

    it "has many comments" do
      comment = Comment.create

      user.comments << comment
      user.save

      expect(comment.user).to eq(user)
    end
  end

end
