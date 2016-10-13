require 'rails_helper'

RSpec.describe User, type: :model do

  describe "misc" do
    before (:each) do
      @user = create(:user)
    end

    it "has a valid factory" do
      expect(@user).to be_valid
    end

    it "is valid with a name and email" do
      expect(@user).to be_valid
    end
  end

  describe "information cannot be left blank" do
    before (:each) do
      @user = build(:user)
    end

    it "is invalid without a name" do
      @user.name = nil
      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
    end
    it "is invalid without an email address" do
      @user.email = nil
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      @user.password = nil
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end
  end

  describe "information cannot already be in use" do
    before (:each) do
      @user1 = create(:user, email: 'duplicate@example.com')
    end

    it "is invalid with a duplicate email address" do
      user2 = build(:user, email: 'duplicate@example.com')
      user2.valid?
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  describe "associations" do
    let(:user) { subject }

    it "has many foods through destinations" do
      food = Food.create
      user.foods << food
      user.save

      expect(user.foods).to include(food)
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
