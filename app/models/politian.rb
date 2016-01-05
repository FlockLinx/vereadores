class Politian < ActiveRecord::Base
  enum gender: { male: "2", female: "4" }
  belongs_to :birth_city, class_name: "City"

end
