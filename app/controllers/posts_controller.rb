
require "will_paginate"
class PostsController < ApplicationController
  before_action :set_topic, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_post, only:  [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    if params[:topic_id].present?
      @topic = Topic.find(params[:topic_id])
      @posts = @topic.posts.paginate(page: params[:page])
    else
      @posts = Post.paginate(page: params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @topic = @post.topic
    @comments = @post.comments
    @tags = @post.tags
    @ratings = @post.ratings.group(:value).count
  end



  # GET /topics/:topic_id/posts/:id/edit
  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  # POST /topics/:topic_id/posts
  def new
    @topic = Topic.find(params[:topic_id])
    @posts = Post.all.includes(:comments)
    @post = @topic.posts.new

  end

  # POST /topics/:topic_id/posts
  def create

    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(post_params)

    if @post.save
      create_or_delete_posts_tags(@post,params[:post][:tags])
      redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end
  # PATCH/PUT /topics/:topic_id/posts/:id

  def update
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    if @post.update(post_params)
      create_or_delete_posts_tags(@post, params[:post][:tags])
      redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully updated.'
    else
      puts @post.errors.full_messages.inspect
      render :edit
    end
  end

  def create_rating
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.create(rating_params)
    redirect_to @post
  end



  # DELETE /topics/:topic_id/posts/:id
  def destroy
    @post.destroy
    redirect_to topic_posts_path(@topic), notice: 'Post was successfully destroyed.'
  end

  private
  def rating_params
    params.require(:rating).permit(:value)
  end
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :topic_id, tags: [])
  end
  def create_or_delete_posts_tags(post, tags)
    post.taggables.destroy_all
    tags = tags.strip.split(',')
    tags.each do |tag|
      post.tags << Tag.find_or_create_by(name: tag)
    end
  end


end
