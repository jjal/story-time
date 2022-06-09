# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  # config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  # config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  # config.current_user_method = "current_user"
end

# # Create application badges (uses https://github.com/norman/ambry)
# Merit::Badge.create!(
#  	{
# 	   id: 1,
# 	   level: 1,
# 	   name: 'words',
# 	   description: 'Has written more than 2000 words in total.',
# 	   custom_fields: {level_name: 'Intern'}
# 	})
# Merit::Badge.create!({
# 	   id: 2,
# 	   level: 2,
# 	   name: 'words',
# 	   description: 'Has written more than 4000 words in total.',
# 	   custom_fields: {level_name: 'Writer'}
# 	})
# Merit::Badge.create!({
# 	   id: 3,
# 	   level: 3,
# 	   name: 'words',
# 	   description: 'Has written more than 2000 words in total. This person is a word making machine.',
# 	   custom_fields: {level_name: 'Wordsmith'}
# 	})
# Merit::Badge.create!({
# 	   id: 4,
# 	   level: 1,
# 	   name: 'heart',
# 	   description: 'Has received a perfect rating for a story.',
# 	   custom_fields: {level_name: 'Endearing'}
# 	})
# Merit::Badge.create!({
# 	   id: 5,
# 	   level: 2,
# 	   name: 'heart',
# 	   description: 'Beloved of the masses. More than 10 perfect ratings amongst all stories.',
# 	   custom_fields: {level_name: 'Populist'}
# 	})
