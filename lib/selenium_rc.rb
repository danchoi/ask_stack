require 'selenium/client'

class SeleniumRc

  attr_accessor :browser
  def initialize(url="http://www.google.com")
    @url = url
    @browser = Selenium::Client::Driver.new \
        :host => "localhost",
        :port => 4444,
        :browser => "*firefox",
        :url => @url,
        :timeout_in_second => 60
  end

  def open_session
    begin
      @browser.start_new_browser_session
      yield @browser
    ensure
      @browser.close_current_browser_session
    end
  end

  def run
    open_session do |browser|
      browser.open "/"
      browser.type "q", "Selenium seleniumhq.org"
      #browser.click "btnG", :wait_for => :page
      puts browser.get_html_source
      #puts browser.text?("seleniumhq.org")
    end
  end

end

if __FILE__  == $0
  s = SeleniumRc.new
  s.run
end
