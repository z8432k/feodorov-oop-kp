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

      print_menu
    end

    def print_boxes(domain)
      ap @data.boxes_of(domain)
              .map(&:to_s)

      print_menu
    end

    def print_aliases
      it = @data.aliases.each

      loop do
        begin
          al = it.next
          puts "FROM: #{al.lp}@#{al.domain} TO: #{al.goto}"
        rescue StopIteration
          return
        end
      end
    end

    def add_domain(domain_name)
      #@data.add_strategy = Data::AddDomainStrategy.new
        @data.add_domain(domain_name)
        puts "Ok"
      print_menu
      rescue => e
        puts e.message
    end

    def add_box(box, password)
      lp, domain = split_check_box(box)

      raise Error.new("Password not found") unless
        password

      @data.add_box(domain, lp, password)
      puts "Ok"
      print_menu
    rescue => e
      puts e.message

      #@data.add_strategy = Data::AddBoxStrategy.new
      #@data.add()
    end

    def set_password(box, old, new)
      lp, domain = split_check_box(box)

      raise Error.new("Old password not found") unless
        old

      raise Error.new("New password not found") unless
        new

      @data.set_password(domain, lp, old, new)
      puts "Ok"
      print_menu
    rescue => e
      puts e.message
    end

    def save
      @data.save
      print_menu
    end

    def print_menu
      puts ""
      puts "Основное меню:"
      puts "* domains - Вывести список доменов."
      puts "* boxes domain - Вывести список ящиков для домена."
      puts "* domain add name - Добавить домен."
      puts "* box add name - Добавить ящик для домена."
      puts "* box pass box old new - Установить пароль для ящика."
      puts "* save - Сохранить изменения"
    end

    private

    def split_check_box(box)
      lp, domain = box.split("@")

      raise Error.new("Local part not found") unless
        lp

      raise Error.new("Domain not found") unless
        domain

      [lp, domain]
    end

  end
end
