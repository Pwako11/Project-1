#Our CLI Controller
class Startup_Match::CLI
attr_accessor :name

  def call
    puts "Current Top 50 startups"
    list_startups
    hire_match
    menu
    goodbye
  end

  def list_startups
    @startups = Startup_Match::Startup.topfifty
    @startups.each.with_index(1) do |startup, i|
      #puts "#{i}. #{startup_1.name}"
    end
  end

  def hire_list
    @hirelist = Startup_Match::Startup.topfifty
    @hirelist.each.with_index(1) do |hire, i|
    end
  end

  def hire_match
    puts "These companies are hiring"
    @startups.each do |x|
      if (@hirelist.include?(x))
      puts "#{x} "
      end
    end
  end

  def menu
    input  = nil
    while input != "exit"
      puts "Enter the number of the Startup you would like more info on:"
      input = gets.strip.downcase

      if input.to_i > 0  && input.to_i <=50
        puts @startups[input.to_i-1]
      elsif input == "list"
        list_startups
      elsif input == "match"
        hire_match
      else
        puts "Make a selection from the listed Startups, enter match to see what startups are hiring or select exit"
      end
    end
  end

  def goodbye
    puts "Thank you for using the Startup match app!"
  end
end
