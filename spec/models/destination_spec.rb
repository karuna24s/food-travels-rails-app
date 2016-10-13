require 'rails_helper'

RSpec.describe Destination, type: :model do
  before :each do
    @destination = Destination.create(
      title: 'Enjoying Gol Gappas in Delhi',
      content: 'Defintely check out this savory and spicy snack.',
      location: 'Delhi, India',
      recommendation: 'Practically every street corner in India.'
      )
  end

  describe "information is valid" do
    it "is valid with a title, content, and location" do
      expect(@destination).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a title" do
      destination = Destination.new(title: nil)
      destination.valid?
      expect(destination.errors[:title]).to include("can't be blank")
    end
    it "is invalid without content" do
      destination = Destination.new(content: nil)
      destination.valid?
      expect(destination.errors[:content]).to include("can't be blank")
    end
    it "is invalid without a location" do
      destination = Destination.new(location: nil)
      destination.valid?
      expect(destination.errors[:location]).to include("can't be blank")
    end
  end

end
