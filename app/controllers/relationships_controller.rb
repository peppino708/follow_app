class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    following = current_user.active_relationships.build(follower_id: params[:user_id])
    following.save
    # request.referrerと書くことによって、以前のパスに戻ることができる
    redirect_to request.referrer || root_path
  end

  def destroy
    following = current_user.active_relationships.find_by(follower_id: params[:user_id])
    following.destroy
    # request.referrerと書くことによって、以前のパスに戻ることができる
    redirect_to request.referrer || root_path
  end
  # なぜ3行目や9行目の記述で自動的にfollwing_idにcurrent_userのidが入るのか？？
  # →user.rbでhas_many :relationships, foreign_key: :following_idと記述しているため、current_user.relationshipsとすると自動的にfollowing_idにcurrent_userのidが入る
end
