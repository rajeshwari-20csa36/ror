class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :set_comment, only: [:show, :destroy]
  before_action :authenticate_user!

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/:id
  def show

  end

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to topic_post_path(@post.topic, @post), notice: 'Comment was successfully added.'
    else
      render :show
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to topic_post_path(@post.topic, @post), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    @comment.destroy
    redirect_to topic_post_path(@post.topic, @post), notice: 'Comment was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end

