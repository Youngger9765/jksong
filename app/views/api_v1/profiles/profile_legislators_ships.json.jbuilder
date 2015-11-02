json.user_max_vote @user_max_vote_number

json.legislator @similar_legislators do |le|
  json.id le[:legislator].id
  json.name le[:legislator].name
  json.image_url le[:legislator].image
  json.total_score le[:score]
  json.party le[:legislator].party
  json.county le[:legislator].county



  json.score_table @categories do |c|
    json.category c.name
    json.le_get_score le[:legislator].profile_legislator_ships.first.get_score(c.english_name)
    json.profile_score_max @profile.category_score_max(c.english_name)
  end

end
