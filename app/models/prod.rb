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

  def self.search(term, page)
    if term
      where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 5).order('id DESC')
    else
      paginate(page: page, per_page: 5).order('id DESC') 
    end
  end
end
