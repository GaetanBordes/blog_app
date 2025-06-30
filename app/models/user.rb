class User < ApplicationRecord
   has_many :articles
  has_many :comments, dependent: :destroy 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
