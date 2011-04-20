require 'yaml'
require 'selenium_rc'
require 'nokogiri'
require 'uri'
require 'iconv'
require 'date'

module StackOverflow
  class Ask

    class PageNotFound < StandardError ; end 

    attr_accessor :url, :sel, :browser, :config
    alias :page :browser

    LOGIN_URL = 'http://stackoverflow.com/users/login' 

    def initialize(config)
      @url = LOGIN_URL
      @sel = SeleniumRc.new(@url)
      @sel.browser.start_new_browser_session
      @browser = @sel.browser
      browser.highlight_located_element=true
      @config = config
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
      puts "On Google signin page. Signing into Google"
      puts page.get_all_fields.inspect
      page.type "Email", config['username']
      page.type "Passwd", config['password']
      puts "Signing in..."
      page.click "signIn", :wait_for => :page
    end

    def ask
      page.click "nav-askquestion"
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
  so.login
  so.ask
end


__END__

<input type="text" name="Email"  id="Email"
  size="18" value="" class='gaia le val' />

<input type="password" name="Passwd" id="Passwd" size="18" 

<input type="submit" class="gaia le button" name="signIn" id="signIn"
value="Sign in" /> 


