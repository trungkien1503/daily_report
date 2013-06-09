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
    
    Activation.create!(user_id: @admin.id, activation_status: "activated")
        
    10.times do |n|
      @group = Group.new
      @group.name = "group-#{n+1}"
      @group.manager = n+2
      @group.save
      
      name  = "catalog-#{n+1}"
      document = "Catalog No.#{n+1}"
      Catalog.create!(name: name,
                      document: document)
      
      @user = User.new
      @user.name = "user-#{n+1}"
      @user.email = "user-#{n+1}@framgia.com"
      @user.password = "foobar"
      @user.password_confirmation = "foobar"
      @user.activation_token = Digest::MD5::hexdigest(@user.email)
      @user.save
      
      GroupUser.create!(user_id:@user.id,group_id:@group.id)
      Activation.create!(user_id: @user.id, activation_status: "activated")
      
      @user = User.new
      @user.name = "user-#{n+11}"
      @user.email = "user-#{n+11}@framgia.com"
      @user.password = "foobar"
      @user.password_confirmation = "foobar"
      @user.activation_token = Digest::MD5::hexdigest(@user.email)
      @user.save
      Activation.create!(user_id: @user.id, activation_status: "inactivated")
    end
  end
end