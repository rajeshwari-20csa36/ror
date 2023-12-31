
class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  def show
    @topic = Topic.find(params[:id])

    from_date = params[:from_date] || 1.day.ago.to_date
    to_date = params[:to_date] || Date.current

    puts "From Date: #{from_date}, To Date: #{to_date}"
    @posts = @topic.posts.created_between(from_date, to_date)
                   .includes(:comments, :tags, :ratings, :read_by_users)
                   .paginate(page: params[:page])
  end


  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create

    @topic = Topic.new(topic_params)

    if @topic.save
      # SignUpMailer.signup_confirmation(current_user).deliver_now
      SignUpMailerJob.perform_later(current_user)
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /topics/1
  def destroy

    @topic.destroy
    redirect_to topics_url, notice: 'Topic was successfully deleted.'
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end

