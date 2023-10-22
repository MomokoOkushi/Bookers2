class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { minimun:1, maximum: 200 }
end
