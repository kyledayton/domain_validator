module DomainHelpers

  def valid_domains
    [
      "example.com",
      "host.test.ly"
    ]
  end

  def invalid_domains
    [
      "notarealdomain",
      "something.withinvalidtld"
    ]
  end

end