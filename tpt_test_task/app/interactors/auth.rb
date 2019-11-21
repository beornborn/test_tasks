require 'jwt'

class InvalidTokenError < StandardError
end

class Auth
  def self.issue(payload)
    JWT.encode(payload, ENV['rails_secret'])
  end

  def self.decode(token)
    JWT.decode(token, ENV['rails_secret'])
  rescue
    raise InvalidTokenError
  end
end
