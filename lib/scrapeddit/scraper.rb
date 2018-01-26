class Scrapeddit::Scraper

attr_accessor :page, :doc, :subreddit

	def initialize(subreddit = "")
		@page = Scrapeddit::Page.new
		@subreddit = subreddit
		load_page
	end

	def load_page
		begin
		@doc = Nokogiri::HTML(open("http://www.reddit.com/#{@subreddit}"))
		rescue OpenURI::HTTPError
		load_page
	  end 
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