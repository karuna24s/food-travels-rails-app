require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @comment = Comment.create(
      content: 'Excellent Post.',
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

  describe "associations" do
    let(:comment) { subject }

    it 'belongs to a destination' do
      destination = Destination.create
      comment.destination = destination
      comment.save

      expect(destination.comments).to include(comment)
    end

    it 'belongs to a user' do
      user = User.create
      comment.user = user
      comment.save

      expect(user.comments).to include(comment)
    end
  end
end
