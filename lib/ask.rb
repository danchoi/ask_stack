require 'yaml'
require 'nokogiri'
require 'uri'
require 'iconv'
require 'date'
require 'selenium/client'

module StackOverflow
  class Ask

    class PageNotFound < StandardError ; end 

    attr_accessor :url, :sel, :browser, :config
    alias :page :browser

    LOGIN_URL = 'http://stackoverflow.com/users/login' 

    def initialize(config)
      @url = LOGIN_URL
      @browser = Selenium::Client::Driver.new \
        :host => "localhost",
        :port => 4444,
        :browser => "*firefox",
        :url => @url,
        :timeout_in_second => 60

      browser.start_new_browser_session
      browser.highlight_located_element=true
      @config = config
    end

    def run
      login
      ask
      stop
    end

    def login
      browser.open url
      puts "Signing in"
      browser.run_script "openid.signin('google')"
      puts "Loading Google signin"
      browser.wait_for_page_to_load(7)
      if !at_google_signin?
        puts "Error: Not the Google signin page. Tomfoolery afoot."
        exit
      end
      # TODO separate this Open ID provider signin to pluggable class
      puts "On Google signin page. Signing into Google"
      page.type "Email", config['username']
      page.type "Passwd", config['password']
      puts "Signing in..."
      page.click "signIn", :wait_for => :page
    end

    def ask
      save_cookie # for next time
      page.click "nav-askquestion"
    end

    def stop
      browser.close
      browser.stop
    end

    def save_cookie
      cookies = page.get_cookie
      puts cookies.inspect
    end

    private

    def at_google_signin?
      browser.get_location =~ %r{^https://www.google.com/accounts/ServiceLogin}
    end

    def ascii(s)
      Iconv.conv("US-ASCII//translit/ignore", 'utf-8', s)
    end
  end
end

if __FILE__ == $0
  creds = YAML::load(File.read("gmail.yml"))
  so = StackOverflow::Ask.new creds
  so.run
end


__END__

<input type="text" name="Email"  id="Email"
  size="18" value="" class='gaia le val' />

<input type="password" name="Passwd" id="Passwd" size="18" 

<input type="submit" class="gaia le button" name="signIn" id="signIn"
value="Sign in" /> 


