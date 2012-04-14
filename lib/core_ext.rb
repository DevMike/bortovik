# encoding: UTF-8

String.class_eval do
  UMLAUT_TRANSLITERATIONS = {
    'ä' => 'ae',
    'Ä' => 'Ae',
    "ü" => 'ue',
    "Ü" => 'Ue',
    "ö" => 'oe',
    "Ö" => 'Oe',
    "ß" => 'ss'
  }

  def transliterate_umlaut
    transliterated = self.clone
    UMLAUT_TRANSLITERATIONS.each do |umlaut, transliteration|
      transliterated.gsub!(/#{umlaut}/, transliteration)
    end
    transliterated
  end
end