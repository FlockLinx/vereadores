# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.vereadores.org"
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "http://files.vereadores.org/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.create do

  # Politian.find_each do |poli|
  #   add politian_path(poli), :lastmod => poli.updated_at, :priority => 1
  # end

  City.find_each do |city|
    add city_path(city), :lastmod => DateTime.now, :priority => 1
  end
end
