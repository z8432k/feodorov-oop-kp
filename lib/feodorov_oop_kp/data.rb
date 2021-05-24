module FeodorovOopKp
  autoload :Domain
  autoload :Mailbox
  autoload :Alias


  class Data
    attr_reader :aliases, :domains, :mailboxes

    def initialize
      raw = YAML.load_file("data.yml")
        .deep_symbolize_keys!

      @domains = Domain.create raw[:domains]
      @mailboxes = Mailbox.create raw[:mailboxes]
      @aliases = Alias.create raw[:aliases]
    end

    def boxes_of(domain)
      @mailboxes.filter do |b|
        b.domain == domain
      end
    end

    def box_exists?(domain, lp)
      !get_box(domain, lp).nil?
    end

    def get_box(domain, lp)
      @mailboxes.filter { |b| b.domain == domain && b.lp == lp }
                .first
    end

    def domain_exists?(domain)
      exists?(@domains, domain.domain, :domain)
    end

    def add_domain(domain_name)
      domain = Domain.new(domain: domain_name, is_active: true)

      raise Error.new("Domain already exists.") if
        domain_exists?(domain)

      @domains.push(domain)
    end

    def add_box(domain, lp, password)
      box = Mailbox.new(domain: domain, lp: lp, quota: 100)
      box.password = password

      raise Error.new("Box already exists.") if
        box_exists?(domain, lp)

      @mailboxes.push(box)
    end

    def set_password(domain, lp, old, new)
      box = get_box(domain, lp)

      raise Error.new("Box not found.") unless
        box

      box.update_password(old, new)
    end

    private

    def exists?(enum, target, field)
      enum.any? { |e| e.instance_variable_get("@#{field}") === target }
    end
  end
end

