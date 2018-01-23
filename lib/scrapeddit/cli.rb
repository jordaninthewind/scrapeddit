class Scrapeddit::CLI

  def initialize
    puts "Get Ready to Scrape Some Gold!"
    x = Scrapeddit::Scraper.new
    @page = x.scrape
  end

  def run
    input = ""
    while input != "exit"
      puts "What would you like to do? (list or exit)"
      input = gets.chomp
      case input
	    when "list"
	      list_posts
	      puts ""
	      puts "Type a Number to Open Link"
	    when "exit"
	      puts "Have a great day!"
	      exit
	    else
	      system("open #{@page.posts[input.to_i-1].url}")
      end
    end
    run
  end

  def list_posts
    @page.posts.each.with_index do | post, num|
      puts "#{num + 1}. #{post.title}"
      puts "	Votes: #{post.votes} Subreddit: #{post.subreddit}"
    end
  end
end