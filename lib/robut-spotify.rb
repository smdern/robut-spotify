require "robut-spotify/version"
require 'hallon'
require 'robut'

module Robut::Plugin::Spotify
  include Robit::Plugin

  class << self
    # Your Spotify API Key
    attr_accessor :key

    attr_accessor :secret

    attr_accessor :port

    attr_accessor :host
  end

  def self.start_server
    # @server = Thread.new { Server.run! :host => (host || "localhost"), :port ( port || 4567) }
    # Server.token = self.token
    # Server.domain = self.domain || "localhost"
  end

end
