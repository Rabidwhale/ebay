class Prod < ApplicationRecord
  validates :name, :description, :cost, presence: true

  mount_uploaders :images, ImageUploader

  belongs_to :user
  has_many :comments
  belongs_to :category

  def default_image
    return images.first.url if images.any?
    "default_image"
  end
end
