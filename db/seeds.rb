7.times do
  User.create!(
    name: Faker::JapaneseMedia::Doraemon.unique.character,
    email: Faker::Internet.unique.email,
    password: '12345678',
    password_confirmation: '12345678'
  )
end

15.times do |index|
  Board.create!(
    user: User.offset(rand(1..User.count - 1)).first,
    title: "タイトル：#{Faker::Music::RockBand.unique.name}",
    body: "本文：#{Faker::Creature::Animal.unique.name}"
  )
end