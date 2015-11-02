json.metadata do
  json.total Issue.count
end

json.data @issues do |i|
  json.id i.id
  json.name i.name
  json.picture image_url(i.logo)
  json.content i.content
  json.category i.category.name
  json.created_at i.created_at
end