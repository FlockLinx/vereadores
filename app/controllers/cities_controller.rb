class CitiesController < ApplicationController

  def show
    @city = City.find params[:id]
    @election = Election.last
    search = { city: @city, election: @election, page: params[:page] }
    case params[:filtro]
    when "suplentes"
      @politians = ElectedPolitians.alternates(search)
    when "nao-eleitos"
      @politians = ElectedPolitians.not_electeds(search)
    else
      params[:filtro] = "eleitos"
      @politians = ElectedPolitians.electeds(search)
    end
  end
end
