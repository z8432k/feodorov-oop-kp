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

    def add_box(box, password)
      lp, domain = box.split("@")

      raise Error.new("Local part not found") unless
        lp

      raise Error.new("Domain not found") unless
        domain

      raise Error.new("Password not found") unless
        password

      @data.add_box(domain, lp, password)
      puts "Ok"
    rescue => e
      puts e.message

      #@data.add_strategy = Data::AddBoxStrategy.new
      #@data.add()
    end
  end
end
