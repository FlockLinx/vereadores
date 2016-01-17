class CampaingDecorator
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper

  include ActionView::Context
  attr_reader :campaing

  delegate :job_name, :status_result_name, :year,
   :education_level_name, :civil_status_name, :job_name, :coalition_name,
   :coalition_parties, :city_name, :number, :state, :state_name, :politian, :city, :status_result, :status_application_name,
   :coalition_content, to: :campaing

  def initialize(campaing)
    @campaing = campaing
  end

  def budget
    number_to_currency(campaing.budget, :separator => ",",
                        :delimiter => ".", :unit => "R$")
  end

  def party_name
    "#{campaing.party_name} - #{campaing.party_acronym}"
  end

  def name_politian_urna
    campaing.name_campain
  end

  def coaliation_parties_list
    content_tag :ul do
      campaing.coalition_parties.each do |p|
        concat(content_tag :li, "#{p.name} - #{p.acronym}")
      end
    end
  end

end
