module Tvdb2
  class Series
    FIELDS = FIELDS + [:slug]

    attr_accessor :slug
  end
end
