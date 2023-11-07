class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { minimun:1, maximum: 200 }

  scope :most_favorited, ->{includes(:favorited_users).sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


end
