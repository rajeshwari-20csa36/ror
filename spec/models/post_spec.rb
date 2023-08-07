# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    let(:topic) { Topic.create(name: "Sports") }

    it "is valid with a title, content, and topic" do
      post = Post.new(title: "My Post", content: "This is the content.", topic: topic)
      expect(post).to be_valid
    end

    it "is invalid without a title" do
      post = Post.new(title: nil, content: "This is the content.", topic: topic)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it "is invalid without content" do
      post = Post.new(title: "My Post", content: nil, topic: topic)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end

    it "is invalid without a topic" do
      post = Post.new(title: "My Post", content: "This is the content.", topic: nil)
      expect(post).not_to be_valid
      expect(post.errors[:topic]).to include("must exist")
    end
  end

  describe "associations" do
    it "belongs to a topic" do
      post = Post.new(title: "My Post", content: "This is the content.")
      expect(post).to respond_to(:topic)
    end
  end
end
