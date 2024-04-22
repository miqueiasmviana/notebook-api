namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    puts "Cadastrando os tipos de contato"
    
    kinds = [
      {description: "Friend"},
      {description: "Commercial"},
      {description: "Known"}       
    ]

    kinds.each do |kind|
      Kind.find_or_create_by!(kind)
    end
    
    puts "Tipos de Contato cadastrados com sucesso."

    puts "Cadastrando os contatos"
    
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: '1960-01-01', to: '2006-01-01'),
        kind: Kind.all.sample
      )
    end

    puts "Contatos cadastrados com sucesso."

  end
end
