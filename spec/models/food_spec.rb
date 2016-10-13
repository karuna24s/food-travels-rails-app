require 'rails_helper'

RSpec.describe Food, type: :model do
  before :each do
    @food = Food.create(
      name: 'Gol Gappa',
      category: 'Vegetarian'
      )
  end

  describe "information is valid" do
    it "is valid with a name" do
      expect(@food).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a name" do
      food = Food.new(name: nil)
      food.valid?
      expect(food.errors[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    let(:food) { subject }

    it "has many users through destinations" do
      user = User.create

      food.users << user
      food.save

      expect(user.foods).to eq(food)
    end

    it "has many destinations" do
      destination = Destination.create

      food.destinations << destination
      food.save

      expect(destination.food).to eq(food)
    end
  end

end
