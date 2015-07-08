#!/usr/bin/ruby

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
