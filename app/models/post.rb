class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :post_image




  # def post_image_url
  #   # Rails.application.routes.url_helpers.url_for(post_image) if post_image.attached?
  # end
end
