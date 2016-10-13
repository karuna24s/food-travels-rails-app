require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @comment = Comment.create(
      content: 'Excellent Post.'
      )
  end

  describe "information is valid" do
    it "is valid with a content" do
      expect(@comment).to be_valid
    end
  end

  describe "information cannot be left blank" do
    it "is invalid without a content" do
      comment = Comment.new(content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include("can't be blank")
    end
  end
end
