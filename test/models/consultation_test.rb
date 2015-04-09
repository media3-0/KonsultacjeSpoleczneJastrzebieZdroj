# == Schema Information
#
# Table name: consultations
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  content           :text
#  consultation_type :integer
#  created_at        :datetime
#  updated_at        :datetime
#  formid            :string(255)
#  end_date          :datetime
#

require 'test_helper'

class ConsultationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
