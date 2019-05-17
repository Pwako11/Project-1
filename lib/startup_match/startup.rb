class Startup_Match::Startup
attr_accessor :name

  def self.topfifty
    #Scrape calcalistech.com and glassdor for data on startups and open positions.
    #Startup_Match::Startup_scrapper.new
    scrape_startups
    scrape_hirelist
  end

  def self.scrape_startups
    #Go to calcalistech.com and gather startups.
    #Extract Startup details to include Startup, name, industry, funding and investors
    startups =[]
    startups << self.scrape_calcalistech
    startups
  end

  def self.scrape_calcalistech
    doc = Nokogiri::HTML(open ("https://www.calcalistech.com/ctech/articles/0,7340,L-3761835,00.html"))

    doc.css("#article-regular .art-edited-content span:first-child").css("strong").each do |strong|
      if strong.text.start_with?("#")
        startup_1 = self.new
        startup_1.name = strong

        puts startup_1.name
      end
    end
  end

  def self.scrape_hirelist
    #Go to glassdoor.com and list of 15 coolest startups currently hiring.
    #Extract Startup details to include Startup name
    hirelist = []
    hirelist << self.scrape_glassdoor
    hirelist
  end

  def self.scrape_glassdoor
    lst = Nokogiri::HTML(open ("https://www.glassdoor.com/blog/15-coolest-startups-to-work-for-now/"))

    lst.css("#siteHeader .entry-content span:first-child").css("b").each do |name|
      hire_1 = self.new
      hire_1.name = name

      puts hire_1.name
    end
  end
end
