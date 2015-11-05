json.category @higher_legislators_by_category[0]

json.legislators @higher_legislators_by_category[1][:rank] do |le|
  json.id le[:id]
  json.name le[:name]
  json.party le[:party]
  json.party_logo le[:party_logo]
  json.image le[:image]
end