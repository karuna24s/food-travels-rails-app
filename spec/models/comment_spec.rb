require 'rails_helper'

RSpec.describe Comment, type: :model do
  before (:each) do
    @comment = create(:comment)
  end

  describe "misc" do
    it "has a valid factory" do
      expect(@comment).to be_valid
    end

    it "is valid with content" do
      expect(@comment).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without content" do
      @comment.content = nil
      @comment.valid?
      expect(@comment.errors[:content]).to include("can't be blank")
    end
  end

  describe "associations" do
    let(:comment) { subject }

    it 'belongs to a destination' do
      expect(@comment.destination).to eq(@destination)
    end

    it 'belongs to a user' do
      expect(@comment.user).to eq(@user)
    end
  end
end
