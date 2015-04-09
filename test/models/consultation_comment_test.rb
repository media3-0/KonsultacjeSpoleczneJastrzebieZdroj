# == Schema Information
#
# Table name: consultation_comments
#
#  id                             :integer          not null, primary key
#  content                        :text
#  created_at                     :datetime
#  updated_at                     :datetime
#  user_id                        :integer
#  consultation_id                :integer
#  parent_consultation_comment_id :integer
#

require 'test_helper'

class ConsultationCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
