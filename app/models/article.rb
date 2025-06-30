class Article < ApplicationRecord
    belongs_to :user
  has_many :comments, dependent: :destroy # Ligne à ajouter

  validates :title, presence: true
  validates :content, presence: true
end
