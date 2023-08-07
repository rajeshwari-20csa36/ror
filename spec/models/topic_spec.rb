# spec/models/topic_spec.rb

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe "validations" do
    it "is valid with a name" do
      topic = Topic.new(name: "Sports")
      expect(topic).to be_valid
    end

    it "is invalid without a name" do
      topic = Topic.new(name: nil)
      expect(topic).not_to be_valid
      expect(topic.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      existing_topic = Topic.create(name: "Sports")
      new_topic = Topic.new(name: "Sports")
      expect(new_topic).not_to be_valid
      expect(new_topic.errors[:name]).to include("has already been taken")
    end
  end

  describe "associations" do
    it "has many posts" do
      topic = Topic.new(name: "Sports")
      expect(topic).to respond_to(:posts)
    end
  end
end
