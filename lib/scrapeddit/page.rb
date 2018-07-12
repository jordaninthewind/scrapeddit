class Scrapeddit::Page

attr_accessor :posts, :subreddit

# @@all = []

	# def add_posts(posts)
	# 	@@all << posts
	# end

	def initialize
		@posts = []
	end

	def add_posts(post)
		@posts << post
	end

end