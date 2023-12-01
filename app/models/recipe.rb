class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :user, presence: true
end
