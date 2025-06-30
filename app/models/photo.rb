# app/models/photo.rb
class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :image, presence: true # On s'assure qu'une photo est bien envoyée
end