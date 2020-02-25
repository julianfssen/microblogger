require 'jumpstart_auth'

class MicroBlogger
    attr_reader :client

    def initialize
        puts "Initializing Microblogger"
        @client = JumpstartAuth.twitter
    end

    def tweet(message)
        if message.length > 140
            puts "Character length too long. Try again"
        else
            @client.update(message)
        end
    end
    
    def dm(target, dm_body)
        puts "Trying to send #{target} this message: "
        puts dm_body
        message = "@#{target} #{dm_body}"
        if check_followers(target)
            tweet(message)
            puts "Message sent"
        else
            puts "Your recipient is not following you."
        end
    end

    def check_followers(target)
        screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name}
        if screen_names.include?(target)
            return true
        else
            return false
        end
    end

    def run
        puts "Welcome to the JSL Twitter Client!"
        command = ""
        while command != "q"
            printf "enter command: "
            input = gets.chomp
            parts = input.split(" ")
            command = parts[0]
            target = parts[1]
            message = parts[1..-1].join(" ")
            direct_message = parts[2..-1].join(" ")

            case command
                when 'q' then puts "Goodbye!"
                when 't' then tweet(message)
                when 'dm' then dm(target, direct_message)
                else
                    puts "Sorry, I don't know how to #{command}"
            end
        end
    end

    blogger = MicroBlogger.new
    blogger.run
end