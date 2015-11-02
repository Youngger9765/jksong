json.profile @profile

json.user_email @user.email
json.mobile_fpush @user.mobile_push
json.county @profile.location.try(:name)