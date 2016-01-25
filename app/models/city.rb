class City < ActiveRecord::Base
  belongs_to :state
  delegate :name, :full_name, to: :state, prefix: true, allow_nil: true

  def to_param
    "#{id} #{name}".to_url
  end
end
