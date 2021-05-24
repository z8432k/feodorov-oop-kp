require 'digest'

module FeodorovOopKp
  autoload :Loadable

  class Mailbox < Loadable
    attr_accessor :domain, :lp
    attr_reader :password

    def initialize(**args)
      @domain = args[:domain]
      @lp = args[:lp]
      @quota = args[:quota]
      @password = args[:password]
    end

    def to_s
      "#{@lp}@#{@domain} PW: #{@password[0..5]}..."
    end

    def password=(password)
      @password = Digest::SHA256.hexdigest(password)
    end
  end
end
