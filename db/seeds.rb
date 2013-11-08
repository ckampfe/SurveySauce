require 'faker'

10.times do
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password_digest: Faker::Lorem.word)
end

10.times do |i|
  Survey.create(user_id: i + 1, title: Faker::Company.name)
end

10.times do |i|
  Survey.find(i + 1).questions << Question.create(body: Faker::Lorem.sentence)
end

10.times do |i|
  Question.find(i + 1).choices << Choice.create(option: Faker::Lorem.word)
end

10.times do |i|
  User.find(i + 1).responses << Response.create(question_id: i + 1, choice_id: i + 1)
end

10.times do |i|
  User.find(i + 1).completes << Complete.create(survey_id: i + 1)
end
