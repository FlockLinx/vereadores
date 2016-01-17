class State < ActiveRecord::Base
  has_many :cities
  scope :tse_states, -> { where.not(name: "ZZ").order(:name) }

  def tse_cities
    cities.where.not(tse_id: "-1").order(:name)
  end

  def tse_cities_with_index(index)
    tse_cities.where("unaccent(cities.name) like?", "#{index}%")
  end
end
