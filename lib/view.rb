class View

  def ask_country
    puts 'Which country do you want to scrape? (Use two character country code, ex. CN)'
    gets.chomp.upcase
  end

  def return_country_color(country, colour)
    puts "#{country} colour is #{colour}!"
  end
end
