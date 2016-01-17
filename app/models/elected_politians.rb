module ElectedPolitians
  def self.electeds(options)
    CampaingsDecorator.new(
      politians_list(options).merge(StatusResult.electeds)
    )
  end

  def self.alternates(options)
    CampaingsDecorator.new(
      politians_list(options).merge(StatusResult.alternates)
    )
  end

  def self.not_electeds(options)
    CampaingsDecorator.new(
      politians_list(options).merge(StatusResult.not_electeds)
    )
  end

  private

  def self.politians_list(options)
    Campaing.joins(:status_result)
    .where(city: options[:city],
           election: options[:election])
    .page(options[:page])
  end

  def self.campaing_decorator_array(list)
    list.map{|item| CampaingDecorator.new(item)}
  end
end
