class Scrapeddit::CLI

attr_reader :subreddit

  def initialize
    system('clear')
    puts "\t\t   Get Ready to Scrape Some Gold!\n\n"
    select_subreddit
  end

    def select_subreddit
    puts "Which Subreddit Would You Like to Open? (r/... or press 'enter' for Front Page)"
    input = gets.strip
    x = Scrapeddit::Scraper.new(input)
    @page = x.scrape
    # binding.pry

    # Removes Subreddit Posting from Listing of Voted Subreddits
    if @page.posts.count > 25
      @page.posts.shift
    end

    # Sets Instance Subreddit
    if input != ""
      @subreddit = input
    else
      @subreddit = "Front Page"
    end
    run
  end

  def run
    system('clear')
    puts "\t\t\tScrapeddit on Reddit #{subreddit}\n\n"
    puts "What would you like to do? (l)ist short, (d)etail, (c)hange subreddit, or e(x)it\n"
    input = gets.strip
    case input
      when "l"
        list_short
      when "d"
        list_detail
      when "c"
        select_subreddit
      when "x"
        puts "Have a great day!"
        exit
      else
        run
    end
  end

  def list_detail
    system('clear')
    puts "\nReddit - Top Posts on #{subreddit} - List Details\n\n"
    
    @page.posts.each.with_index(1) do | post, num |
      puts "#{num}. #{post.title.upcase}"
      puts "    Sub: #{post.subreddit}    Votes: #{post.votes}\n"
      puts "    URL: #{post.url}\n"
    end
    open
  end

  def list_short
    system('clear')
    puts "\nReddit - Top Posts on #{subreddit} - List Articles\n\n"
    
    @page.posts.each.with_index(1) do | post, num |
      puts "#{num}. #{post.title}"
    end
    open
  end

  def open
    puts "\nType a Number to Open Link or Press Enter"
    input = gets.strip

    input.to_i.between?(1,25) ? select_page(input) : run
  end

  def select_page(input)
    if @page.posts[input.to_i-1].url.split(":")[0].include?("http")
        system("open #{@page.posts[input.to_i-1].url}")
    else 
      system("open http://www.reddit.com#{@page.posts[input.to_i-1].url}")
    end
  run  
  end

end
