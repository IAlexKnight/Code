class Song
    @@plays = 0
    def initialize(name, artist, duration)
	@name = name
	@artist = artist
	@duration = duration
	@plays = 0
    end

    def to_s
	"Song: #@name--#@artist(#@duration)"
    end

    def play
	@play += 1
	@@play += 1
	"This song: #@plays plays. Total #@@plays plays."
    end

#    def name
#	@name
#    end
#
#    def artist
#	@artist
#    end
#
#    def duration
#	@duration
#    end

    attr_reader :name, :artist, :duration
    attr_writer :duration

    def duratioin_in_minutes
	@duration/60.0
    end

    def duration_in_minutes=(new_duration)
	@duration = new_duration
    end

end

class KaraokeSong < Song
    def initialize(name, artist, duration, lyrics)
	super(name, artist, duration)
	@lyrics = lyrics
    end

    def to_s
	super + " [#@lyrics]"
    end
end

#Singleton but not handler safe
class MyLogger
    private_class_method :new
    @@logger = nil
    def MyLogger.create
	@@logger = new unless @@logger
	@@logger
    end
end

class Account
    attr_reader :cleared_balance
    protected :cleared_balance
end




















