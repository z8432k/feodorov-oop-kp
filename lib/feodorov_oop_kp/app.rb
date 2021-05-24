require 'singleton'
require "yaml"


module FeodorovOopKp
  autoload :Data

  class App
    include Singleton

    def initialize
      @data = Data.new
      puts @data
    end

    def print_domains
      ap @data.domains
              .map(&:to_s)
    end

    def print_boxes(domain)
      ap @data.boxes_of(domain)
              .map(&:to_s)
    end

    def add_domain(domain_name)
      #@data.add_strategy = Data::AddDomainStrategy.new
        @data.add_domain(domain_name)
        puts "Ok"
      rescue => e
        puts e.message
    end

    def add_box(domain, local_part, password)
      box = Mailbox.new(domain: domain, lp: local_part, quota: 100)
      #box.set

      #@data.add_strategy = Data::AddBoxStrategy.new
      #@data.add()
    end
  end
end
