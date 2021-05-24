module FeodorovOopKp
  autoload :Command

  class ListDomainsCommand < Command
    def execute
      @app.print_domains
    end
  end

end

