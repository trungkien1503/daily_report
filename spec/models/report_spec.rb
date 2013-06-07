# == Schema Information
#
# Table name: reports
#
#  id                 :integer          not null, primary key
#  catalog_id         :integer
#  user_id            :integer
#  content            :text
#  attached_file_data :binary
#  attached_file_name :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Report do
  pending "add some examples to (or delete) #{__FILE__}"
end
