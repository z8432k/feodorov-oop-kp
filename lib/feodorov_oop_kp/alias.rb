module FeodorovOopKp
  class Alias < Loadable
    attr_accessor  :lp, :domain, :goto

    def initialize(**args)
      @domain = args[:domain]
      @lp = args[:lp]
      @goto = args[:goto]
    end
  end
end
