class Scrapeddit::Page

attr_accessor :posts, :subreddit

	def initialize
		@posts = []
	end

	def add_post(post)
		@posts << post
	end

end