require 'rails_helper'

RSpec.describe Destination, type: :model do
  before (:each) do
    @destination = create(:destination)
  end

  describe "misc" do
    it "has a valid factory" do
      expect(@destination).to be_valid
    end

    it "is valid with a title, content, and location" do
      expect(@destination).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a title" do
      @destination.title = nil
      @destination.valid?
      expect(@destination.errors[:title]).to include("can't be blank")
    end
    it "is invalid without content" do
      @destination.content = nil
      @destination.valid?
      expect(@destination.errors[:content]).to include("can't be blank")
    end
    it "is invalid without a location" do
      @destination.location = nil
      @destination.valid?
      expect(@destination.errors[:location]).to include("can't be blank")
    end
  end

  describe "associations" do
    let(:destination) { subject }

    it 'belongs to a food' do
      expect(@destination.food).to eq(@food)
    end

    it 'belongs to a user' do
      expect(@destination.user).to eq(@user)
    end

    it "has many comments" do
      comment = Comment.create
      destination.comments << comment
      destination.save
      expect(comment.destination).to eq(destination)
    end
  end

end
