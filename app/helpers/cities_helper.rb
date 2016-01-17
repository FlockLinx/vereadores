module CitiesHelper

  def filter_text(filter)
    case filter
    when "suplentes"
      "Vereadores Suplente"
    when "nao-eleitos"
      "Vereadores Não Eleitos"
    when "eleitos"
      "Vereadores Eleitos"
    end
  end
end
