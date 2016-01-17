class City < ActiveRecord::Base
  belongs_to :state
  delegate :name, to: :state, prefix: true, allow_nil: true
end
