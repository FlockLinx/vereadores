class CampaingDecorator
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Context
  attr_reader :campaing, :politian, :politian_object

  delegate :job_name, :status_result_name, :year,
   :education_level_name, :civil_status_name, :job_name, :coalition_name,
   :coalition_parties, :state, :state_name,  :city, :status_result, :status_application_name,
   :coalition_content, :party_acronym, to: :campaing

  delegate :name, to: :politian, prefix: true
  delegate :url_helpers, to: 'Rails.application.routes'

  def initialize(campaing)
    @campaing = campaing
    @politian = PolitianDecorator.new(campaing.politian)
    @politian_object = campaing.politian
  end

  def budget
    number_to_currency(campaing.budget, :separator => ",",
                        :delimiter => ".", :unit => "R$")
  end

  def number
    number_with_precision(campaing.number, precision: 0)
  end

  def title
    "#{politian_name} nas Eleições de #{year} para vereador#{set_female_world} de #{city_name}"
  end

  def set_female_world
    "a" if politian_object.gender == "female"
  end

  def party_name
    "#{campaing.party_name} - #{campaing.party_acronym}"
  end

  def city_name
    "#{campaing.city_name} - #{state_name}"
  end

  def coaliation_parties_list
    content_tag :ul do
      campaing.coalition_parties.each do |p|
        concat(content_tag :li, "#{p.name} - #{p.acronym}")
      end
    end
  end

  def releated_campaings_list
    return if campaing.releated_campaings.count == 0
    list = content_tag :h3, "Outros candidatos do #{party_acronym} de #{city_name}"
    list += content_tag :ul do
      campaing.releated_campaings.each do |p|
        concat (content_tag :li do
          link_to p.politian_name, url_helpers.politian_path(p.politian_object)
        end)
      end
    end
    raw list
  end

end
