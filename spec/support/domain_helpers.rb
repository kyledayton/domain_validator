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
      "domain.withinvalidtld"
    ]
  end

end