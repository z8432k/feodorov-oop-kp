require "pry"

module FeodorovOopKp
  module Pry
    COMMANDS = ::Pry::CommandSet.new do
      command "hello", "Send Hello." do |name|
        puts "Hello, #{name}!"
      end

      command :domains, "List domains" do
        App.instance.print_domains
      end

      command :boxes, "List mailboxes of domain" do |domain|
        App.instance.print_boxes domain
      end

      command :domain, "Domain operations" do |cmd, domain|
        case cmd
        when "add"
          App.instance.add_domain(domain)
        else
          puts "Wrong action. Try again."
        end
      end

      command :box, "Mailbox operations" do |cmd, box, a1, a2|
        case cmd
        when "add"
          App.instance.add_box(box, a1)
        when "pass"
          App.instance.set_password(box, a1, a2)
        else
          puts "Wrong action. Try again."
        end
      end
    end
  end
end
