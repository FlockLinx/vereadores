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

  def politian_card(filter)
    case filter
    when "suplentes"
      "bs-callout-warning"
    when "nao-eleitos"
      "bs-callout-danger"
    when "eleitos"
      "bs-callout-primary"
    end
  end
end
