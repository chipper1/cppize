module Cppize
  class Transpiler
    @library_path = (if options.has_key?["no-stdlib"]
      [File.join(File.dirname(Process.executable_path),"stdlib/build")]
    else
      [""]
    end) + ENV["CRYSTAL_STDLIB_PATH"].split(":")

    def add_library_path(p)
      @library_path << p
    end

    def search_file(str)
      @library_path.select do |path|
        File.exists?(File.join(path,str))
      end.last?
    end

    register_node Require do
      path = node.string
      filename = ""
      if path.starts_with? "."
        filename = File.join(File.dirname(@current_filename),path)
      else
        filename = search_file path
        if filename.nil?
          raise Error.new("Cannot find #{path}!",node,nil,@current_filename)
        end
      end

      old_filename = @current_filename
      Lines.new do |l|
        l.line("// Begin #{filename} (#{path})")
        l.line(transpile(Parser.parse(filename)))
        l.line("// End #{filename} (#{path})")
      end
      @current_filename = old_filename
    end
  end
end
