json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :name
  json.url post_url(post, format: :json)
end
