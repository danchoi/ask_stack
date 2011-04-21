require 'yaml'
require 'nokogiri'
require 'uri'
require 'iconv'
require 'date'
require 'selenium/client'

class AskStack

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
    browser.set_browser_log_level 'debug'
    @config = config
  end

  def run
    browser.window_maximize
    login
    page.click "nav-askquestion", :wait_for => :page
    fill_form
    sleep 3
    submit
    sleep 2
    puts "You question is posted at this URL" 
    puts browser.get_location 
    stop
    puts "Done"
  end

  def fill_form
    puts "Filling in question form"
    page.type "name=title", config[:question][:title]
    page.focus 'name=post-text'
    sleep 1
    page.type "name=post-text", config[:question][:body]
    page.type_keys "name=post-text", " "
    sleep 1
    page.type "name=tagnames", config[:question][:tags]
  end

  def submit
    puts "Submitting"
    page.click 'id=submit-button', :wait_for => :page
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

  def stop
    browser.close
    browser.stop
  end

  # http://stackoverflow.com/search/titles?like=what%20is%20the%20best%20way%20to%20test%20in%20ruby%3F&_=1303413037898
  # returns html frag, see similar.txt
  #
  def similar_questions

  end

  # http://stackoverflow.com/filter/tags?callback=jQuery151044475735054025645_1303413170293&q=ruby&limit=6&timestamp=1303413245025&_=1303413245028
  # sample resp:
  # http://stackoverflow.com/filter/tags?q=ruby&limit=6&timestamp=1303413245025&_=1303413245028
  #
  # timestamp divide by 1000
  #
  # jQuery151044475735054025645_1303413170293("ruby|22235\nruby-on-rails|36488\nruby-on-rails-3|7173\nrubygems|1569\njruby|585\nruby-on-rails-plugins|495");[choi kaja~]$
  def complete_tags

  end


  def self.run
    config = YAML::load(File.read("ask_stack.yml"))
    raw_question = STDIN.read.strip
    title = raw_question.split(/^\s*$/)[0]
    tags = raw_question.split(/^\s*$/)[-1]
    body = raw_question.split(/^\s*$/)[1..-2].join("\n")
    config[:question] = {title: title, body: body, tags: tags}
    so = AskStack.new config
    so.run
  end

  private

  def at_google_signin?
    browser.get_location =~ %r{^https://www.google.com/accounts/ServiceLogin}
  end
end

if __FILE__ == $0
  AskStack.run
end

