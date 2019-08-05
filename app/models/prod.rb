class Prod < ApplicationRecord
  validates :name, :description, :cost, presence: true

  mount_uploaders :images, ImageUploader

  belongs_to :user
  has_many :comments
  belongs_to :category
end
