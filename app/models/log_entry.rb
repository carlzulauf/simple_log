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
class LogEntry < ApplicationRecord
  belongs_to :namespace

  before_save :ensure_uuid

  def as_shareable_json
    as_json.without("id")
  end
  private

  def ensure_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
