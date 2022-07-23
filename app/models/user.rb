class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # フォローする側から中間テーブルへのアソシエーション
  has_many :active_relationships, foreign_key: :following_id, class_name: "Relationship", dependent: :destroy
  # フォローする側からフォローされたユーザを取得する
  has_many :followings, through: :active_relationships, source: :follower

  # フォローされる側から中間テーブルへのアソシエーション
  has_many :passive_relationships, foreign_key: :follower_id, class_name: "Relationship", dependent: :destroy
  # フォローされる側からフォローしているユーザを取得する
  has_many :followers, through: :passive_relationships, source: :following
end
