class Campaing < ActiveRecord::Base
  belongs_to :coalition
  belongs_to :party
  belongs_to :job
  belongs_to :politian
  belongs_to :city
  has_one :state, through: :city
  belongs_to :education_level
  belongs_to :election
  belongs_to :status_application
  belongs_to :status_result
  belongs_to :civil_status
  delegate :name, :acronym, to: :party, prefix: true, allow_nil: true
  delegate :name, :parties, :content, to: :coalition, prefix: true, allow_nil: true
  delegate :year, to: :election
  delegate :name, to: :status_application, prefix: true, allow_nil: true
  delegate :name, to: :status_result, prefix: true, allow_nil: true
  delegate :name, to: :education_level, prefix: true, allow_nil: true
  delegate :name, to: :civil_status, prefix: true, allow_nil: true
  delegate :name, to: :job, prefix: true, allow_nil: true
  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :state, prefix: true, allow_nil: true

end
