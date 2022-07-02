Rails.application.reloader.to_prepare do
  # # Create application badges (uses https://github.com/norman/ambry)
  Merit::Badge.create!({
      id: 1,
      level: 1,
      name: 'words',
      description: 'Has written more than 2000 words in total.',
      custom_fields: {level_name: 'Intern'}
  })
  Merit::Badge.create!({
      id: 2,
      level: 2,
      name: 'words',
      description: 'Has written more than 4000 words in total.',
      custom_fields: {level_name: 'Writer'}
  })
  Merit::Badge.create!({
      id: 3,
      level: 3,
      name: 'words',
      description: 'Has written more than 2000 words in total. This person is a word making machine.',
      custom_fields: {level_name: 'Wordsmith'}
  })
  Merit::Badge.create!({
      id: 4,
      level: 1,
      name: 'heart',
      description: 'Has received a perfect rating for a story.',
      custom_fields: {level_name: 'Endearing'}
  })
  Merit::Badge.create!({
      id: 5,
      level: 2,
      name: 'heart',
      description: 'Beloved of the masses. More than 10 perfect ratings amongst all stories.',
      custom_fields: {level_name: 'Populist'}
  })
end