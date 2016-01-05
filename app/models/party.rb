class Party < ActiveRecord::Base
  has_many :coalition_parties
  has_many :coalitions, through: :coalition_parties
end
