class Recipe < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :metadata, presence: true
  validates :user, presence: true

  def title
    metadata["title"]
  end

  def description
    metadata["description"]
  end

  def image_url
    metadata["image"]
  end
end
