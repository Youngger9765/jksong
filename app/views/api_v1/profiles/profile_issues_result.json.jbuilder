json.metadata do
  json.profile @profile.id
end

json.data  @issues  do |i|
  json.issue_id i[:issue].id
  json.issue_category i[:category]
  json.issue_name i[:issue].name
  json.issue_content i[:issue].content
  json.issue_decision i[:decision]
  json.issue_total_yes i[:total_yes]
  json.issue_total_no i[:total_no]
end