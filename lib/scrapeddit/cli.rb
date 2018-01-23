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
    puts "What would you like to do? (list or exit)"
    input = gets.chomp
    case input
      when "list"
        list_posts
      when "exit"
        puts "Have a great day!"
        exit
      else
        open
    end
    # run
  end

  def list_posts
    system('clear')
    puts "Top 25 Reddit Posts\n\n"
    
    @page.posts.each.with_index do | post, num|
      puts "#{num + 1}. #{post.title}"
      puts "	Votes: #{post.votes} Subreddit: #{post.subreddit}"
    end
    
    puts "Type a Number to Open Link"
    input = gets.strip
    system('open #{@page.posts[input.to_i-1].url}')
    run
  end
end


  # def run
  #   input = ""
  #   while input != "exit"
  #     puts "What would you like to do? (list or exit)"
  #     input = gets.chomp
  #     case input
  #    when "list"
  #       system('clear')
  #       puts "Top 25 Reddit Posts\n\n"
  #      list_posts
  #      puts ""
  #      puts "Type a Number to Open Link"
  #    when "exit"
  #      puts "Have a great day!"
  #      exit
  #    else
  #      system("open #{@page.posts[input.to_i-1].url}")
  #     end
  #   end
  #   run
  # end