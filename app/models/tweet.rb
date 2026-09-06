class Tweet < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_one_attached :image
  
end
