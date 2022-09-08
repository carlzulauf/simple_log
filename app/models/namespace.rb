# == Schema Information
#
# Table name: namespaces
#
#  id         :integer          not null, primary key
#  name       :string
#  options    :text
#  uuid       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Namespace < ApplicationRecord
  has_many :log_entries

  scope :recent, -> { order(updated_at: :desc) }

  before_save :ensure_uuid

  def to_param
    uuid
  end

  def display_name
    name.presence || uuid
  end

  private

  def ensure_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
