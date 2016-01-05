module ElectedPolitian
  def self.list(options)
    Politian.joins(campaings: :election).where(campaings: {city: options[:city], election: options[:election]})
  end

end
