# == Schema Information
#
# Table name: activations
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  activation_status :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Activation do
  pending "add some examples to (or delete) #{__FILE__}"
end
