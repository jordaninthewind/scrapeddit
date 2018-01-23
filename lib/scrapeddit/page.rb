class Page
attr_accessor :posts

	def initialize
		@posts = []
	end

	def add_post(post)
		@posts << post
	end
	
end