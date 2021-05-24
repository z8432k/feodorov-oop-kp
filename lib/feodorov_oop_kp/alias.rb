module FeodorovOopKp
  class Alias < Loadable
    def initialize(**args)
      @domain = args[:domain]
      @lp = args[:lp]
      @goto = args[:goto]
    end
  end
end
