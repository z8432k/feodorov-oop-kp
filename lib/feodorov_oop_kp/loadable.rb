module FeodorovOopKp
  autoload :Printable

  class Loadable
    class << self
      def create(args)
        args.map do |a|
          self.new a
        end
      end
    end

    include Printable
  end
end
