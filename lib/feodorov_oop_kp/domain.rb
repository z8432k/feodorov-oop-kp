module FeodorovOopKp
  autoload :Loadable

  class Domain < Loadable
    attr_accessor :domain, :is_active

    printable :domain, :is_active

    def initialize(**args)
      @domain = args[:domain]
      @is_active = args[:is_active]
    end
  end
end
