# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.vereadores.org"

SitemapGenerator::Sitemap.create do

  Politian.find_each do |poli|
    add politian_path(poli), :lastmod => poli.updated_at, :priority => 1,
  end

  City.find_each do |city|
    add city_path(city), :lastmod => city.updated_at, :priority => 0.7,
  end

end
