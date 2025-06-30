# db/seeds.rb

puts "Nettoyage de la base de données..."
Article.destroy_all

puts "Création de 30 articles..."
30.times do
  Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 15)
  )
end

puts "Terminé !"