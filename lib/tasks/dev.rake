namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    show_spinner("Apagando BD...") { %x(rails db:drop) }
    show_spinner("Criando BD...") { %x(rails db:create) }
    show_spinner("Migrando BD...") { %x(rails db:migrate) }

    puts "Cadastrando os tipos de contato..."
    
    kinds = [
      {description: "Friend"},
      {description: "Commercial"},
      {description: "Known"}       
    ]

    kinds.each do |kind|
      Kind.find_or_create_by!(kind)
    end
    
    puts "Tipos de Contato cadastrados com sucesso."

    puts "Cadastrando os contatos..."
    
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: '1960-01-01', to: '2006-01-01'),
        kind: Kind.all.sample
      )
    end

    puts "Contatos cadastrados com sucesso."

    ##############################

    puts "Cadastrando os telefones..."
    
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = contact.phones.create!(number: Faker::PhoneNumber.cell_phone_with_country_code)
      end
    end

    puts "Telefones cadastrados com sucesso."

    ##############################

    puts "Cadastrando os endereços..."
    
    Contact.all.each do |contact|
      address = Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact,
        
      )
    end

    puts "Endereços cadastrados com sucesso."
  end

  def show_spinner(msg_start, msg_end = "Concluído!", &block)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
