json.data @higher_legislators_by_categories do |c, lhl|
  json.category c
  json.legislator  lhl[:rank] do |l|
    json.id l.id
    json.name l.name
    json.party_logo l.party_logo
    json.party l.party
    json.image l.image
  end

end