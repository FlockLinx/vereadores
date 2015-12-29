namespace :data do

  desc "load vereadores data"
  task :vereadores => :environment do
    CSV.foreach("path/to/file.csv") do |row|
      # use row here...
    end
  end
end
