class PolitianDecorator
  attr_reader :politian, :campaing
  delegate :nationality, to: :politian

  def initialize(politian)
    @politian = politian
  end

  def name
    politian.politian_urna_name || politian.name
  end

  def full_name
    politian.name
  end

  def birth
    "Nascimento: #{I18n.l(politian.birth_date)} - #{politian.age} anos"
  end

  def gender
    "Gênero: #{politian.gender == "male" ? "Masculino" : "Feminino"}"
  end

  def birth_city
    "Cidade Nascimento: #{politian.birth_city_name} - #{politian.birth_city_state_name} - #{nationality}"
  end
end
