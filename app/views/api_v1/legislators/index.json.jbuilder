json.category @higher_legislators_by_category[0]

json.legislator @higher_legislators_by_category[1][:rank] do |le|
  json.id le[0][:id]
  json.name le[0][:name]
  json.party le[0][:party]
  json.party_logo le[0][:party_logo]
  json.image le[0][:image]

  json.score_max le[1].sort{|a,b|b[1]<=>a[1]}[1][1]
  json.score_table le[1] do |s|
    json.category s[0]
    json.le_get_score s[1]
  end
end