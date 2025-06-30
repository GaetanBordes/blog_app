# db/seeds.rb
puts "Nettoyage de la base de données..."
Article.destroy_all
User.destroy_all

puts "Création d'un utilisateur de test..."
user = User.create!(
  email: "test@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "Création de 30 articles pour l'utilisateur #{user.email}..."
30.times do
  user.articles.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 15)
  )
end

puts "Terminé !"