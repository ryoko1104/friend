class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = tweet.comments.build(comment_params) #buildを使い、contentとtweet_idの二つを同時に代入
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    end
  end

  def edit
  @comment = Comment.find(params[:id])
  @tweet = Tweet.find(params[:tweet_id])
  end

def update
  @tweet = Tweet.find(params[:tweet_id])
  @comment = Comment.find(params[:id])

  if @comment.user_id == current_user.id
    @comment.update(comment_params)
    redirect_to tweet_path(@comment.tweet_id)
  else
    redirect_to tweet_path(@comment.tweet_id)
  end
end

def destroy
  @tweet = Tweet.find(params[:tweet_id])
  @comment = Comment.find(params[:id])
  tweet_id = @comment.tweet_id

  if @comment.user_id == current_user.id
    @comment.destroy
  end

  redirect_to tweet_path(tweet_id)
end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end