require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:topic) { Topic.create(name: 'Example Topic') }

  before do
    10.times do
      topic.posts.create(title: 'Example Post', content: 'This is the content of the post.')
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index, params: { topic_id: topic.id }
      expect(response).to render_template(:index)
    end

    it "assigns @posts" do
      get :index, params: { topic_id: topic.id }
      expect(assigns(:posts)).to eq(topic.posts)
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      post = topic.posts.first
      get :show, params: { topic_id: topic.id, id: post.id }
      expect(response).to render_template(:show)
    end

    it "assigns @post" do
      post = topic.posts.first
      get :show, params: { topic_id: topic.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new, params: { topic_id: topic.id }
      expect(response).to render_template(:new)
    end

    it "assigns a new Post to @post" do
      get :new, params: { topic_id: topic.id }
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    it "creates a new post" do
      expect {
        post :create, params: { topic_id: topic.id, post: { title: "New Post", content: "New content" } }
      }.to change(Post, :count).by(1)
    end

    it "redirects to the created post" do
      post :create, params: { topic_id: topic.id, post: { title: "New Post", content: "New content" } }
      expect(response).to redirect_to(topic_post_path(topic, assigns(:post)))
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      post = topic.posts.first
      get :edit, params: { topic_id: topic.id, id: post.id }
      expect(response).to render_template(:edit)
    end

    it "assigns the requested post to @post" do
      post = topic.posts.first
      get :edit, params: { topic_id: topic.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "PATCH #update" do
    it "updates the requested post" do
      post = topic.posts.first
      patch :update, params: { topic_id: topic.id, id: post.id, post: { title: "Updated Post" } }
      post.reload
      expect(post.title).to eq("Updated Post")
    end

    it "redirects to the post" do
      post = topic.posts.first
      patch :update, params: { topic_id: topic.id, id: post.id, post: { title: "Updated Post" } }
      expect(response).to redirect_to(topic_post_path(topic, post))
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = topic.posts.first
      expect {
        delete :destroy, params: { topic_id: topic.id, id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = topic.posts.first
      delete :destroy, params: { topic_id: topic.id, id: post.id }
      expect(response).to redirect_to(topic_posts_path(topic))
    end
  end
end
