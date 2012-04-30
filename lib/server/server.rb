require 'robut'
require 'sinatra'
require 'json'

class Robut::Plugin::Spotiffy
  include Robut::Plugin

  class Server < Sinatra::Base

    set :root, File.dirname(__FILE__)

    class << self
      attr_accessor :queue
      attr_accessor :command

      attr_accessor :token
      attr_accessor :domain

      attr_accessor :reply_callback
      attr_accessor :state_callback

      attr_accessor :last_played_track
    end

    self.queue = []
    self.command = []

    get '/' do
      File.read(File.expand_path('public/index.html', File.dirname(__FILE__)))
    end

    get '/js/vars.js' do
      content_type 'text/javascript'
      <<-END
      var spotify_token = '#{self.class.token}';
      var spotify_domain = '#{self.class.domain}';
      END
    end

    # Returns the sources that haven't been fetched yet.
    get '/queue.json' do
      queue = self.class.queue.dup
      self.class.queue = []
      queue.to_json
    end

    # Returns the command for the player
    get '/command.json' do
      command = self.class.command.dup
      self.class.command = []
      command.to_json
    end

    # Make an announcement into the Hipchat channel
    get '/announcement/:message' do
      self.announce! URI.unescape(params[:message].to_s)
    end

    # Make a now playing announcmenet into the Hipchat channel
    get '/now_playing/:title' do
      track_title = URI.unescape(params[:title].to_s)

      if self.track_is_not_the_same_as_last? track_title
        self.state! "is now playing: #{track_title}"
        self.class.last_played_track = track_title
      end
    end

    def state!(message)
      self.class.state_callback.call(message) if self.class.state_callback
    end

    def announce!(message)
      self.class.reply_callback.call(message) if self.class.reply_callback
    end

    def track_is_not_the_same_as_last? current_track
      self.class.last_played_track != current_track
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end

