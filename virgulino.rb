#!/usr/bin/ruby

class String
def green;          "\033[32m#{self}\033[0m" end
end

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

puts "What do you wanna do?"
puts "[1 - to encrypt]".green
puts "[2 - to decrypt]".green
answer = gets.chomp

if answer == "1"
    puts "Write whatever text you want to encrypt and press enter."
    $text = gets.chomp
    $text2= ""
    
    #convert string to bin
    $text.bytes.each {|x| $text2 += x.to_s(2)}
    #convert bin to spaces and tabs
    
    $text2.gsub!(/[10]/, "1" => "\t", "0" => " ")
    f = File.new("virgulino", "w") #make file with stego
    f.write($text2)
    f.close
    puts "Your file is done! It`s name is virgulino."
elsif answer == "2"
    exist=false
    while exist != true
    puts "Enter the encrypted filename:"
    $file= gets.chomp
    if File.exist?("#{$file}")
        exist=true
        stegofile = File.read("#{$file}")

        #convert spaces/tabs to bin
	    stegofile.gsub!(/[\t]/, "\t" => "1", " " => "0")
        puts "What should be the output filename?"
        name_file = gets.chomp
	f = File.new("#{name_file}", "w")
	f.write(stegofile)
	f.close
	puts "Done! Do you want to see it? (y/n)"
	answer_view = gets.chomp
        if answer_view == "y"
            puts stegofile
        else
            puts "Your file has been created successfuly!"
        end
    else
	puts name_file + " was not found."
    end
    end
end
