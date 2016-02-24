namespace :import do
  desc 'Import all from Signal v. Noise Archive and Older Archive, Getting Real, and 37signals Manifesto'
  task all: :environment do
    Importer.import_all do |document|
      Document.create! document
    end
  end

  desc 'Import all from Medium - separate task because it requires selenium'
  task medium: :environment do
    Importer.new(Parser::Medium.new).import do |document|
      Document.create document
    end
  end
end
