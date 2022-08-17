# == Schema Information
#
# Table name: log_entries
#
#  id           :integer          not null, primary key
#  content      :text
#  content_type :string
#  headers      :text
#  uuid         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  namespace_id :integer          not null
#
# Indexes
#
#  index_log_entries_on_namespace_id  (namespace_id)
#
# Foreign Keys
#
#  namespace_id  (namespace_id => namespaces.id)
#
require "test_helper"

class LogEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
