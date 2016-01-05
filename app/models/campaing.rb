class Campaing < ActiveRecord::Base
  belongs_to :coalition
  belongs_to :party
  belongs_to :job
  belongs_to :politian
  belongs_to :city
  belongs_to :education_level
  belongs_to :election
  belongs_to :status_application
  belongs_to :status_result
  belongs_to :civil_status


end
