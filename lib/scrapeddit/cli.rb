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
    puts "What would you like to do? (l)ist short, (d)etail, (c)hange subreddit, or e(x)it"
    input = gets.chomp
    case input
      when "l"
        list_short
      when "d"
        list_posts
      when "c"
        select_subreddit
      when "x"
        puts "Have a great day!"
        exit
      else
        run
    end
  end

  def list_posts
    system('clear')
    puts "\nTop 25 Reddit Posts\n"
    
    @page.posts.each.with_index do | post, num |
      puts "#{num + 1}. #{post.title}"
      puts "	  Votes: #{post.votes} Subreddit: #{post.subreddit} URL: #{post.url}\n"
    end
    
    puts "Type a Number to Open Link or Press Enter"
    input = gets.strip
    to_url(input)
    run
  end

  def list_short
    system('clear')
    puts "\nsTop 25 Reddit Posts\n"
    
    @page.posts.each.with_index do | post, num |
      puts "#{num + 1}. #{post.title}"
    end
    
    puts "\nType a Number to Open Link or Press Enter"
    input = gets.strip
    to_url(input)
    run
  end

  def to_url(input)
    if @page.posts[input.to_i-1].url.split(":")[0].include?("http")
        system("open #{@page.posts[input.to_i-1].url}")
      else 
        system("open http://www.reddit.com#{@page.posts[input.to_i-1].url}")
      end
  end

end
