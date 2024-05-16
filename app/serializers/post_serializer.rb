class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :author_name, :topic, :content, :post_image_url
  # include Rails.application.routes.url_helpers
end
