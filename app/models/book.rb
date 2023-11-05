class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { minimun:1, maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


end
