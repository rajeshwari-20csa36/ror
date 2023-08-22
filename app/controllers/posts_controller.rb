
require "will_paginate"
class PostsController < ApplicationController
  before_action :set_topic, only: [ :show, :edit, :update, :destroy]
  before_action :set_post, only:  [:show, :edit, :update, :destroy]

  before_action :authenticate_user!
  def index
    if params[:topic_id].present?
      @topic = Topic.find(params[:topic_id])
      @posts = @topic.posts.includes(:ratings, :comments).paginate(page: params[:page])
    else
      @posts = Post.includes(:ratings, :comments).paginate(page: params[:page])
    end

    calculate_average_ratings
    calculate_comments_count
  end

  def show
    @post = Post.find(params[:id])
    @topic = @post.topic
    @comments = @post.comments
    @tags = @post.tags
    @ratings = @post.ratings.group(:value).count
    current_user.mark_post_as_read(@post)

  end

  # app/controllers/posts_controller.rb

    def mark_post_as_read
      post = Post.find(params[:post_id])
      current_user.read_posts << post unless current_user.read_posts.include?(post)
      render json: { success: true }
    end


  def edit
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    authorize! :update, @post
  end


  def new
    @topic = Topic.find(params[:topic_id])
    @posts = Post.all.includes(:comments)
    @post = @topic.posts.new
  end

  def create
    @user = current_user
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(post_params.merge(user_id: @user.id))

    if @post.save
      if params[:post][:tags].present?
      create_or_delete_posts_tags(@post,params[:post][:tags])
      end
      redirect_to topic_post_path(@topic, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

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


  def destroy
    @post.destroy
    redirect_to topic_posts_path(@topic), notice: 'Post was successfully destroyed.'
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post

      @post = @topic.posts.find(params[:id])

  end

  def post_params
    params.require(:post).permit(:title, :content, :topic_id, :image, tags: [])
  end
  def create_or_delete_posts_tags(post, tags)
    post.taggables.destroy_all
    tags = tags.strip.split(',')
    tags.each do |tag|
      post.tags << Tag.find_or_create_by(name: tag)
    end
  end
  def calculate_average_ratings
    @average_ratings = {}
    (@posts || []).each do |post|
      total_ratings = post.ratings.count
      sum_ratings = post.ratings.sum(:value)
      @average_ratings[post.id] = total_ratings.zero? ? 0 : sum_ratings.to_f / total_ratings
    end
  end

  def calculate_comments_count
    @comments_count = {}
    (@posts || []).each do |post|
      @comments_count[post.id] = post.comments.count
    end
  end


end
