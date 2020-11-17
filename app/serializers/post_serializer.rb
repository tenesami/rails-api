class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :content
end
