class CoalitionParty < ActiveRecord::Base
  belongs_to :coalition
  belongs_to :party
end
