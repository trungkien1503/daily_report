# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  catalog_id :integer
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  file       :string(255)
#

require 'spec_helper'

describe Report do
  pending "add some examples to (or delete) #{__FILE__}"
end
