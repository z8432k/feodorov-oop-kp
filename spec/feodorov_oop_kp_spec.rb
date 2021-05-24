# frozen_string_literal: true


RSpec.describe FeodorovOopKp do
  it "has a version number" do
    expect(FeodorovOopKp::VERSION).not_to be nil
  end

  it "does something useful" do
    i = FeodorovOopKp::App.instance
    i.print_domains

    expect(true).to eq(true)
  end

  it "Print mailboxes" do
    i = FeodorovOopKp::App.instance
    i.print_boxes "yandex.ru"

    expect(true).to eq(true)
  end
end

RSpec.describe Data do
  it "check exists_domain" do
    app = FeodorovOopKp::App::instance

    app.add_domain("yandex.ru")
  end
end
