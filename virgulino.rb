#!/usr/bin/ruby

def splash()
    puts"****************************************************"
    puts"*         __                    __ __               *"
    puts"* .--.--.|__|.----.-----.--.--.|  |__|.-----.-----. *"
    puts"* |  |  ||  ||   _|  _  |  |  ||  |  ||     |  _  | *"
    puts"*  \\___/ |__||__| |___  |_____||__|__||__|__|_____| *"
    puts"*                 |_____|                           *"
    puts"*                                                   *"
    puts"* Virgulino Ver. 0.1                                *"
    puts"* coded by n3k00n3                                  *"
    puts"* LampiaoSEC - Security Research Group              *"
    puts"* #lampiaosec at freenode                           *\n"
    puts"*****************************************************\n"
end
splash()

puts "What do you want?"
puts "[1 - encrypter]"
puts "[2 - decrypter]"
answer = gets.chomp

if answer == "1"
    puts "write what you want and press enter."
    text = gets.chomp
    
    #Here we need to conver to bin
    text.gsub!(/[10]/, "1" => "\t", "0" => " ")
    f = File.new("virgulino", "w")
    f.write(text)
    f.close
    puts "your file is done!"
elsif answer == "2"
    puts "what the file name?"
    $file= gets.chomp
    if File.exist?("#{$file}")
        stegofile = File.read("#{$file}")
	stegofile.gsub!(/[\t ]/, "\t" => "1", " " => "0")
	f = File.new("virgulino", "w")
	f.write(stegofile)
	f.close
	puts "Done! do you want to see?(y/n)"
	answer_view = gets.chomp
        if answer_view == "y"
            puts stegofile
        else
            puts "your file has been created!"
        end
    else
	puts "This file exist?"
    end
end
