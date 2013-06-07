namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    10.times do |n|
      name  = "catalog-#{n+1}"
      document = "No.#{n+1}report cong viec se lam:"
      Catalog.create!(name: name,
                      document: document)
    end
  end
end