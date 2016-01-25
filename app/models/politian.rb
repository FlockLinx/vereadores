class Politian < ActiveRecord::Base
  enum gender: { male: "2", female: "4" }
  belongs_to :birth_city, class_name: "City"
  has_many :campaings
  delegate :name, :state_name, to: :birth_city, prefix: true, allow_nil: true

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def last_campaing
    campaings.last if campaings.present?
  end

  def politian_urna_name
    last_campaing.name_campain if last_campaing.present?
  end

  def to_param
    "#{id} #{politian_urna_name}".to_url
  end

end
