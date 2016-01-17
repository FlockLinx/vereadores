class StatusResult < ActiveRecord::Base
  scope :electeds, -> { where(tse_id: ["2", "3"]) }
  scope :alternates, -> { where(tse_id: ["5"]) }
  scope :not_electeds, -> { where(tse_id: ["4", "-1"])}
end
