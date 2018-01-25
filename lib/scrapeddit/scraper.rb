class Scrapeddit::Scraper

attr_accessor :page, :doc

	def initialize(subreddit = "")
		@page = Scrapeddit::Page.new
		@doc = Nokogiri::HTML(open("http://www.reddit.com/#{subreddit}"))
	end

	def scrape
		scrape_posts
		@page
	end
	
	def scrape_posts
	    @doc.css("div.thing").each do | post |
	      x = Scrapeddit::Post.new
	      x.title = post.css("a.title.may-blank").text.strip
	      x.subreddit = post.css("a.subreddit").text.strip
	      x.votes = post.css("div.score.unvoted").text.strip
	      x.url = post.css("a.title.may-blank")[0]['href']
		  page.add_post(x)
	    end
	end

end