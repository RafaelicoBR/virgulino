#!/usr/bin/ruby

class String
    def green; "\033[32m#{self}\033[0m" end
    def red;"\033[31m#{self}\033[0m" end
end

class Virgulino

    def splash()
        puts "\e[1;1H\e[2J]]"
        puts"*****************************************************".green
        puts"*         __                    __ __               *".green
        puts"* .--.--.|__|.----.-----.--.--.|  |__|.-----.-----. *".green
        puts"* |  |  ||  ||   _|  _  |  |  ||  |  ||     |  _  | *".green
        puts"*  \\___/ |__||__| |___  |_____||__|__||__|__|_____| *".green
        puts"*                 |_____|                           *".green
        puts"*                                                   *".green
        puts"* Virgulino v0.1                                    *".green
        puts"* coded by:                                         *".green
        puts"*      n3k00n3   -   nekoone (at) riseup(dot)net    *".green
        puts"*      UserX     -   user_x(at)riseup(dot_net       *".green
        puts"*      Cascudo                                      *".green
        puts"*      gjuniioor -   gjuniioor@protonmail.ch        *".green
        puts"* LampiaoSEC - Security Research Group              *".green
        puts"* #lampiaosec at freenode                           *".green
        puts"* https://lampiaosec.github.io                      *".green
        puts"*                                                   *".green
        puts"*****************************************************\n".green
    end

    def bin_to_s(str)
        newstr = ""
        counter = 0
        final = ""

        str.each_char do |x| 
            newstr += x
            counter += 1
            if counter == 7
                final += (newstr.to_i (2)).chr
                counter = 0
                newstr = ""
            end
        end

        final 
    end

    def encrypt()
        puts "Write whatever text you want to encrypt and press enter.".green
        $text = gets.chomp
        $text2= ""
        
        #convert string to bin
        $text.bytes.each do |x| 
            if (x < 0x40) 
                $text2 += '0'
            end
            $text2 += x.to_s(2)
        end


        #convert bin to spaces and tabs
        $text2.gsub!(/[10]/, "1" => "\t", "0" => " ")
        f = File.new("virgulino", "w") #make file with stego
        f.write($text2)
        f.close
        puts "Your file is done! It`s name is virgulino.".green
    end

    def decrypt()
        exist=false
        while exist != true
           puts "Enter the encrypted filename:".red
           $file= gets.chomp
           
            if File.exist?("#{$file}")
                exist=true
                stegofile = File.read("#{$file}")

                #convert spaces/tabs to bin
        	    stegofile.gsub!(/[\t]/ , "\t" => "1")
                stegofile.gsub!(/[ ]/ , "0")
                print "Stegofile: " + stegofile + "\n"
                stegofile = bin_to_s(stegofile)
                puts "What should be the output filename?".red
                name_file = gets.chomp
            	f = File.new("#{name_file}", "w")
            	f.write(stegofile)
            	f.close
            	puts "Done! Do you want to see it? (y/n)".red
            	answer_view = gets.chomp
                if answer_view == "y"
                    puts stegofile.green + "\n"
                else
                    puts "Your file has been created successfuly!".red
                end
            else
        	   puts (name_file + " was not found.").red
            end
        end
    end

    def menu()
        puts "What do you wanna do?".green
        puts "[e - to encrypt]".green
        puts "[d - to decrypt]".green
        puts "[q - to quit]".green
        puts "\n"
        answer = gets.chomp
        answer
    end


    def main()
        while true
            splash()
            todo = menu()
            if todo == "e"
                encrypt()
            elsif todo == "d"
                decrypt()
            elsif todo == "q"
                puts "\nSee you later!\n".red
                exit()
            else
                puts todo.length < 1 ? "Unrecognized option!" : "\nUnrecognized option: " << todo.red << "!"
                puts "Try again!\n".red
                puts "Press enter to continue... "
                gets.chomp
            end
        end
    end
end

if __FILE__ == $0
    virgulino = Virgulino.new
    virgulino.main()
end
