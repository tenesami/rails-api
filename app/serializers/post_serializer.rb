class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :content
  belogs_to :user
end
