class TweetsController < ApplicationController
  before_action :authenticate_user!, only: 

  def index
   @tweets = Tweet.all
   search = params[:search]
   if search.present?
     search_word = "%#{search}%"
     @tweets = @tweets.where(
      "name LIKE :search OR age LIKE :search OR community LIKE :search OR birthday LIKE :search OR personality LIKE :search OR birthplace LIKE :search",
      search: search_word
     )
   end
  end

  def new
    @tweet = Tweet.new
  end

 def create
  tweet = Tweet.new(tweet_params)
  tweet.user = current_user

  if tweet.save
    redirect_to action: "index"
  else
    puts tweet.errors.full_messages
    redirect_to action: "new"
  end
 end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
  end


  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:name, :age, :community, :birthday, :photo, :personality, :birthplace, :image)
  end
end
