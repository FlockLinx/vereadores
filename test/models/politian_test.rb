require 'test_helper'

class PolitianTest < ActiveSupport::TestCase
  test "the truth" do
    puts Politian.first.inspect
    puts Politian.first.birth_city.inspect

  end
end
