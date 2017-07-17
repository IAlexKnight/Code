class CyclicTagRule < TagRule
    FIRST_CHARACTER = '1'

    def initialize(append_characters)
        super(FIRST_CHARACTER, append_characters)
    end

    def inspect
        "#<CyclicTagRule #{append_characters}>"
    end
end

class CyclicTagRulebook < Struct.new(:rules)
    DELETION_NUMBER = 1

    def initialize(rules)
        super(rules.cycle)
    end

    def applies_to?(string)
        string.length >= DELETION_NUMBER
    end

    def next_string(string)
        follow_next_rule(string).slice(DELETION_NUMBER..-1)
    end

    def follow_next_rule(string)
        rule = rules.next

        if rule.applies_to?(string)
            rule.follow(string)
        else
            string
        end
    end
end

rulebook = CyclicTagRulebook.new([
    CyclicTagRule.new('1'), CyclicTagRule.new('0010'), CyclicTagRule.new('10')
])

system = TagSystem.new('11', rulebook)
16.times do 
    puts system.current_string
    system.step
end; puts system.current_string




















