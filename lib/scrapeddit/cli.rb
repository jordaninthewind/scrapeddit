class Scrapeddit::CLI

attr_reader :subreddit

  def initialize
    puts "Get Ready to Scrape Some Gold!"
    select_subreddit
  end

    def select_subreddit
    puts "Which Subreddit Would You Like to Open? (r/... or 'enter' for Front Page)"
    input = gets.strip
    x = Scrapeddit::Scraper.new(input)
    @page = x.scrape
    if input != ""
      @subreddit = input
    else
      @subreddit = "Front Page"
    end
    run
  end

  def run
    puts "What would you like to do? (l)ist short, (d)etail, (c)hange subreddit, or e(x)it"
    input = gets.chomp
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
    puts "Top 25 Reddit Posts on #{subreddit} - List Details\n\n"
    
    @page.posts.each.with_index(1) do | post, num |
      puts "#{num}. #{post.title}"
      puts "	  Votes: #{post.votes} Subreddit: #{post.subreddit} URL: #{post.url}\n"
    end
    
    puts "Type a Number to Open Link or Press Enter"
    input = gets.strip

    if input == ""
      run
    else
      select_page(input)
    end
  end

  def list_short
    system('clear')
    puts "Top 25 Reddit Posts on #{subreddit} - List Articles\n\n"
    
    @page.posts.each.with_index(1) do | post, num |
      puts "#{num}. #{post.title}"
    end
    
    puts "\nType a Number to Open Link or Press Enter"
    input = gets.strip

    input == "" ? run : select_page(input)

  end

  def select_page(input)
    if @page.posts[input.to_i-1].url.split(":")[0].include?("http")
        system("open #{@page.posts[input.to_i-1].url}")
      else 
        system("open http://www.reddit.com#{@page.posts[input.to_i-1].url}")
      end
  end

end
