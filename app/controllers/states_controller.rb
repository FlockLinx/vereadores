class StatesController < ApplicationController

  def index
    @states = State.all.tse_states
  end

  def show
    @state = State.find params[:id]
    @cities = params[:indice].present? ? @state.tse_cities_with_index(params[:indice]) : @state.tse_cities
  end
end
