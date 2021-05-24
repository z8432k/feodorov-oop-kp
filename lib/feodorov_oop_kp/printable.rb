module FeodorovOopKp
  module Printable
    extend ActiveSupport::Concern

    class_methods do
      def printable(*argv)
        class_eval do
          @@printable = argv
        end
      end
    end

    def to_s
      @@printable.map {|v| "#{v}: #{self.instance_variable_get("@#{v}")}" }
                 .join(" ")
    end
  end
end
