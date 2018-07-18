class Scrapeddit::Scraper

attr_accessor :page, :doc, :subreddit, :count

	def initialize(subreddit = "")
		@page = Scrapeddit::Page.new
		@subreddit = subreddit
		@count = 1
		load_page
	end

	def load_page
		begin
		  @doc = Nokogiri::HTML(open("http://old.reddit.com/#{@subreddit}"))
		rescue OpenURI::HTTPError
		  puts "Attempt Number: #{@count}"
		  @count += 1
		  sleep(2)
		  load_page
	  	end
	end

	def scrape
		scrape_posts
		@page
	end


	def scrape_posts
	    posts = @doc.css("div.thing").map do | post |
	      x = Scrapeddit::Post.new
	      x.title = post.css("a.title.may-blank").text.strip
	      x.subreddit = post.css("a.subreddit").text.strip
	      x.votes = post.css("div.score.unvoted").text.strip
	      x.url = post.css("a.title.may-blank")[0]['href']
	      x
	    end
		@page.add_posts(posts)
	end

end