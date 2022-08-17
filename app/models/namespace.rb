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

  validates :name, presence: true

  def to_param
    name
  end
end
