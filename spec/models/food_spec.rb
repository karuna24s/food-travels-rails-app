require 'rails_helper'

RSpec.describe Food, type: :model do
  before (:each) do
    @food = create(:food)
  end

  describe "misc" do
    it "has a valid factory" do
      expect(@food).to be_valid
    end

    it "is valid with a name" do
      expect(@food).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a name" do
      @food.name = nil
      @food.valid?
      expect(@food.errors[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    let(:food) { subject }

    it "has many users through destinations" do
      user = User.create
      food.users << user
      food.save
      expect(food.users).to include(user)
    end

    it "has many destinations" do
      destination = Destination.create
      food.destinations << destination
      food.save
      expect(destination.food).to eq(food)
    end
  end

end
