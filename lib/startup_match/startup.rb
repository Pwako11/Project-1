class Startup_Match::Startup
attr_accessor :name, :details

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
    startup_details = []
    startup_details << self.scrape_calcalistech2
  end

  def self.scrape_calcalistech
    result = []
    doc = Nokogiri::HTML(open ("https://www.calcalistech.com/ctech/articles/0,7340,L-3761835,00.html"))

    doc.css("#article-regular .art-edited-content span:first-child").css("strong").each do |strong|
      if strong.text.start_with?("#")
        startup_1 = self.new
        startup_1.name = strong.text
        startup_1.details = gather_details(strong)
        result << startup_1
      end
    end
    result
  end

  def self.gather_details(title_tag)
    if title_tag.parent.name == "p"
      title_tag = title_tag.parent
    end
    result = []
    tag = title_tag.next_sibling
    while tag && tag.attr("class") != "blanktag"
      result << tag.text
      tag = tag.next_sibling
    end
    result
  end

  def self.scrape_hirelist
    #Go to indeed.com and list of companies currently hiring.
    #Extract Startup details to include Startup name
    hirelist = []
    hirelist << self.scrape_indeed
    hirelist
  end

  def self.scrape_indeed
    result = []
    lst = Nokogiri::HTML(open ("https://www.indeed.com/jobs?q=developer&l=Hyattsville%2C+MD"))

    lst.css("#resultsCol .jobsearch-SerpJobCard  span:first-child").css("company").each do |name|
      hire_1 = self.new
      hire_1.name = name

    result << hire_1
    end
    result
  end
end
