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
      @password = hash(password)
    end

    def check_password(pass)
      raise Error.new("Wrong old password") unless
        @password == hash(pass)
    end

    def update_password(old, new)
      check_password(old)
      self.password = new
    end

    private

    def hash(pass)
      Digest::SHA256.hexdigest(pass)
    end
  end
end
