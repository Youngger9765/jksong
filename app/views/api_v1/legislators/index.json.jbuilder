json.metadata do
  json.total Legislator.count
end

json.data @legislators do |le|
  json.id le.id
  json.name le.name
  json.gender le.gender
  json.county le.county
  json.party le.party
  json.ad le.ad
  json.in_office le.in_office
  json.education le.education
  json.experience le.experience
  json.image le.image

end