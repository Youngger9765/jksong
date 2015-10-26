json.metadata do
  json.total Issue.count
end

json.data @issues do |i|
  json.id i.id
  json.name i.name
  json.created_at i.created_at
end