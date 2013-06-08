namespace :db do
  CarrierWave.clean_cached_files!
  desc "Fill database with sample data"
  task populate: :environment do
    10.times do |n|
      name  = "catalog-#{n+1}"
      document = "Catalog No.#{n+1}"
      Catalog.create!(name: name,
                      document: document)
    end
  end
end