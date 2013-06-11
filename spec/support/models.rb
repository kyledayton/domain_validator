class User < Model
  validates :domain, :domain => true
end

class UserAllowsNil < Model
  validates :domain, :domain => {:allow_nil => true}
end

class UserAllowsNilFalse < Model
  validates :domain, :domain => {:allow_nil => false}
end

class UserAllowsBlank < Model
  validates :domain, :domain => {:allow_blank => true}
end

class UserAllowsBlankFalse < Model
  validates :domain, :domain => {:allow_blank => false}
end

class UserWithMessage < Model
  validates :domain, :domain => {:message => "isn't quite right"}
end

class UserVerifyDNS < Model
  validates :domain, :domain => {:verify_dns => true}
end

class UserVerifyDNSFalse < Model
  validates :domain, :domain => {:verify_dns => false}
end

class UserVerifyDNSMessage < Model
  validates :domain, :domain => {:verify_dns => {:message => "failed DNS check"}}
end