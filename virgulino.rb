#!/usr/bin/ruby

class String
    def green; "\033[32m#{self}\033[0m" end
end


def splash()
    puts"*****************************************************".green
    puts"*         __                    __ __               *".green
    puts"* .--.--.|__|.----.-----.--.--.|  |__|.-----.-----. *".green
    puts"* |  |  ||  ||   _|  _  |  |  ||  |  ||     |  _  | *".green
    puts"* \\___/ |__||__| |___  |_____||__|__||__|__|_____| *".green
    puts"*                 |_____|                           *".green
    puts"*                                                   *".green
    puts"* Virgulino Ver. 0.1                                *".green
    puts"* coded by n3k00n3                                  *".green
    puts"* LampiaoSEC - Security Research Group              *".green
    puts"* #lampiaosec at freenode                           *\n".green
    puts"*****************************************************\n".green
end

def bin_to_s(str)
    newstr = ""
    counter = 0
    ascii = ""
    
    final = ""
    str.each_char do |x| 
        newstr += x
        counter += 1
        if counter == 7
            ascii = newstr.to_i (2)
            final += ascii.chr
            counter = 0
            ascii = ""
            newstr = ""
        end
    end

    final 
end

def encrypt
    puts "Write whatever text you want to encrypt and press enter.".green
    $text = gets.chomp
    $text2= ""
    
    #convert string to bin
    $text.bytes.each {|x| $text2 += x.to_s(2)}
    #convert bin to spaces and tabs
    $text2.gsub!(/[10]/, "1" => "\t", "0" => " ")
    f = File.new("virgulino", "w") #make file with stego
    f.write($text2)
    f.close
    puts "Your file is done! It`s name is virgulino.".green
end

def decrypt
    exist=false
    while exist != true
        puts "Enter the encrypted filename:".green
        $file= gets.chomp
        if File.exist?("#{$file}")
            exist=true
            stegofile = File.read("#{$file}")

            #convert spaces/tabs to bin
    	    stegofile.gsub!(/[\t]/ , "\t" => "1")
            stegofile.gsub!(/[ ]/ , "0")

            stegofile = bin_to_s(stegofile)

            puts "What should be the output filename?".green
            name_file = gets.chomp
        	f = File.new("#{name_file}", "w")
        	f.write(stegofile)
        	f.close
        	puts "Done! Do you want to see it? (y/n)".green
        	answer_view = gets.chomp
            if answer_view == "y"
                puts stegofile.green
            else
                puts "Your file has been created successfuly!".green
            end
        else
    	   puts name_file + " was not found.".green
        end
    end
end

def menu

    puts "What do you wanna do?".green
    puts "[1 - to encrypt]".green
    puts "[2 - to decrypt]".green
    answer = gets.chomp
    answer
end


def main

    splash()
    if menu() == "1"
        encrypt()
    else 
        decrypt()
    end 

end

main()
