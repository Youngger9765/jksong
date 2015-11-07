json.category @higher_legislators_by_category[0]

json.legislator @higher_legislators_by_category[1][:rank] do |le|
  json.id le[0][:id]
  json.name le[0][:name]
  json.party le[0][:party]
  json.party_logo le[0][:party_logo]
  json.image le[0][:image]

  json.score_max le[2]
  json.score_table le[1] do |s|
    if s[0] == "law"
      json.category "司法/法制"
    elsif s[0] == "diplomacy"
      json.category "外交/國防"
    elsif s[0] == "interior"
      json.category "內政"
    elsif s[0] == "finance"
      json.category "財政"
    elsif s[0] == "economy"
      json.category "經濟"
    elsif s[0] == "traffic"
      json.category "交通"
    elsif s[0] == "education"
      json.category "教育/文化"
    elsif s[0] == "social"
      json.category "社福/衛環"
    elsif s[0] == "total"
      json.category "total"
    end
    json.le_get_score s[1]
  end
end