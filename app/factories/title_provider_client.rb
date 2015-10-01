class TitleProviderClient
  def self.client
    TitleProvider.new(WORDS_GENERATOR_URL)
  end
end
