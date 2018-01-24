class Scrapeddit::CLI

  def initialize
    puts "Get Ready to Scrape Some Gold!"
    select_subreddit
  end

  def select_subreddit
    puts "Which Subreddit Would You Like to Open? (r/... or 'enter' for Front Page)"
    input = gets.strip
    x = Scrapeddit::Scraper.new(input)
    @page = x.scrape
    run
  end

  def run
    # binding.pry
    puts "What would you like to do? (list or list long, change subreddit, or exit)"
    input = gets.chomp
    case input
      when "list"
        list_short
      when "list long"
        list_posts
      when "change subreddit"
        select_subreddit
      when "exit"
        puts "Have a great day!"
        exit
      else
        run
    end
  end

  def list_posts
    system('clear')
    puts "Top 25 Reddit Posts\n"
    
    @page.posts.each.with_index do | post, num |
      puts "#{num + 1}. #{post.title}"
      puts "	  Votes: #{post.votes} Subreddit: #{post.subreddit}"
      puts "    URL: #{post.url}\n"
    end
    
    puts "Type a Number to Open Link or Press Enter"
    input = gets.strip
      if @page.posts[input.to_i-1].url.split(":")[0].include?("http")
        system("open #{@page.posts[input.to_i-1].url}")
      else 
        system("open http://www.reddit.com#{@page.posts[input.to_i-1].url}")
      end
    run
  end

  def list_short
    system('clear')
    puts "Top 25 Reddit Posts\n"
    
    @page.posts.each.with_index do | post, num |
      puts "#{num + 1}. #{post.title}"
    end
    
    puts "\nType a Number to Open Link or Press Enter"
    input = gets.strip
      if @page.posts[input.to_i-1].url.split(":")[0].include?("http")
        system("open #{@page.posts[input.to_i-1].url}")
      else 
        system("open http://www.reddit.com#{@page.posts[input.to_i-1].url}")
      end
    run
  end
end
