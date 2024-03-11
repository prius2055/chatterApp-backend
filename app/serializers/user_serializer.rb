class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :firstname, :lastname, :email, :admin
end
