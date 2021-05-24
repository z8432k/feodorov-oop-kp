module FeodorovOopKp
  autoload :Domain
  autoload :Mailbox
  autoload :Alias


  class Data
    DATA_FILE = "data.yml".freeze

    attr_reader :aliases, :domains, :mailboxes

    def initialize
      raw = YAML.load_file(DATA_FILE)
        .deep_symbolize_keys!

      @domains = raw[:domains]
      @mailboxes = raw[:mailboxes]
      @aliases = raw[:aliases]
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

    def save
      puts "Saving..."
      yaml = YAML.dump({
        domains: @domains,
        mailboxes: @mailboxes,
        alises: @aliases
      })

      File.open DATA_FILE, "w" do |f|
        f.puts yaml
      end
    end

    private

    def exists?(enum, target, field)
      enum.any? { |e| e.instance_variable_get("@#{field}") === target }
    end
  end
end

