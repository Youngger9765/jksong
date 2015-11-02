json.data do
  json.id @issue.id
  json.picture image_url(@issue.logo)
  json.name @issue.name
  json.category_name @issue.category.name
  json.content @issue.content
  json.vote_count @issue.votes.count
end

json.profile do
  json.decision @profile_issue.try(:decision)
end