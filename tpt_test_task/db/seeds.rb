users_config = {
  regular: {
    count: 3,
  },
  manager: {
    count: 1,
  },
  admin: {
    count: 1,
  },
}

users_config.keys.each do |role|
  users_config[role][:count].times do |i|
    user = User.create!(
      email: "#{role}#{i + 1}@gmail.com",
      password: '123123',
      name: Faker::StarWars.character,
      working_minutes: (0..1000).to_a.sample,
    )
    user.add_role role
    puts "User #{user.inspect} created"
  end
end

User.all.each do |u|
  (1..5).to_a.sample.times do
    activity = Activity.create!(
      user: u,
      description: Faker::Lorem.sentence,
      start: Faker::Date.between(7.days.ago, Date.today),
      duration: (1..600).to_a.sample,
    )
    puts "Activity #{activity.inspect} created"
  end
end
