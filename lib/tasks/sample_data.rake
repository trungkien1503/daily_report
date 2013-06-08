namespace :db do
  CarrierWave.clean_cached_files!
  desc "Fill database with sample data"
  task populate: :environment do
    
    @admin = User.new
    @admin.name = "admin"
    @admin.email = "admin@framgia.com"
    @admin.password = "foobar"
    @admin.password_confirmation = "foobar"
    @admin.activation_token = Digest::MD5::hexdigest(@admin.email)
    @admin.save
    
    Activation.create!(user_id: @admin.id, activation_status: "actived")
    
    10.times do |n|
      name  = "catalog-#{n+1}"
      document = "Catalog No.#{n+1}"
      Catalog.create!(name: name,
                      document: document)
    end
  end
end