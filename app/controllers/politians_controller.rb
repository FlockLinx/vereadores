class PolitiansController < ApplicationController

  def show
    politian = Politian.find params[:id]
    campaing = politian.campaings.last
    @politian = PolitianDecorator.new(politian)
    @campaing = CampaingDecorator.new(campaing)
  end
end
