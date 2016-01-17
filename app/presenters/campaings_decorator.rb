class CampaingsDecorator
  include Enumerable

  attr_reader :campaings, :campaings_decorator
  delegate :current_page, :total_pages, :limit_value, to: :campaings

  def initialize(campaings)
    @campaings = campaings
    @campaings_decorator = campaings.map{ |item| CampaingDecorator.new(item)}
  end

  def each(&block)
    @campaings_decorator.each(&block)
    self
  end


end
