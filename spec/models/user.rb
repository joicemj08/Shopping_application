require "rails_helper"

RSpec.describe User, :type => :model do
  it "orders by last name" do
    lindeman = User.create!(first_name: "Andy", last_name: "Lindeman", email: "joice4u4@gmail.com", password: "test@123")
    chelimsky = User.create!(first_name: "David", last_name: "Chelimsky",email: "joice114u4@gmail.com", password: "test1@123")

  end
end
