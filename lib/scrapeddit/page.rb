class Scrapeddit::Page

attr_accessor :posts, :subreddit

	def initialize
		@posts = []
	end

	def add_posts(post)
		@posts << post
	end

end