class Politian < ActiveRecord::Base
  enum gender: { male: "2", female: "4" }
  belongs_to :birth_city, class_name: "City"
  has_many :campaings
  delegate :name, :state_name, to: :birth_city, prefix: true, allow_nil: true

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end
end
