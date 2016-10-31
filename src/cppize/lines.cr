module Cppize
  class Lines
    property? failsafe : Bool

    def initialize(@failsafe = true, &block : Lines -> _)
      @ident = 0
      @code = ""
      block.call self
    end

    def line(str, do_not_place_semicolon : Bool = false)
      # @code += "// ident is #{@ident}\n"
      lines = str.split("\n")
      old_ident = lines.first.match(/^[\s\t]+/) || [""]
      lines.each do |l|
        @code += "\t"*@ident + l.sub(old_ident[0], "")
        @code += ";" if !do_not_place_semicolon && lines.size == 1
        @code += "\n"
      end
    end

    def block(header : String? = nil, &block)
      line header, true if header
      line "{", true
      @ident += 1
      begin
        block.call
      rescue ex : Transpiler::Error
        unless ex.catched?
          line "#error #{ex.message}", true
          ex.catched = true
        end
        raise ex unless @failsafe
      ensure
        @ident -= 1
        line "}", true
      end
    end

    def to_s
      @code
    end
  end
end