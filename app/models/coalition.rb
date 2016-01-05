class Coalition < ActiveRecord::Base
  has_many :coalition_parties
  has_many :parties, through: :coalition_parties

end
