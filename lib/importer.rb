class Importer
  def initialize(parser)
    @parser = parser
  end

  def import(&callback)
    @parser.urls.each do |url|
      callback.call(@parser.document(url))
    end
  end

  def self.import_all(&callback)
    [
      Parser::Manifesto.new,
      Parser::GettingReal.new,
      Parser::OlderArchive.new,
      Parser::Archive.new
    ].each do |parser|
      new(parser).import(&callback)
    end
  end
end
