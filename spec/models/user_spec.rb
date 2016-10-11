require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with an email" do
    user = User.new(email: 'test@example.com', password: 'password')
    expect(user).to be_valid
  end
  it "is invalid without an email address" do
    user = User.new(email: nil, password: 'password')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    User.create(email: 'test@example.com', password: 'password')
    user = User.new(email: 'test@example.com', password: 'password')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
