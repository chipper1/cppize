require "../macros/*"

module Cppize
  class Transpiler
    @@macros = Hash(String, Proc(Transpiler, Call, String)).new

    def self.add_macro(name, &block : Transpiler, Call -> String)
      @@macros[name.to_s] = block
    end

    CPP_OPERATORS = %w(+ - * / % >> << >= <= > < == != & && | || ^)

    ADDITIONAL_OPERATORS = {
      "===" => "equals",
      "=~"  => "find",
      "<=>" => "diff",
    }

    def transpile(node : Call, should_return : Bool = false)
      if should_return
        "return #{transpile node}"
      else
        if node.obj
          if CPP_OPERATORS.includes? node.name
            "(#{transpile node.obj} #{node.name} #{transpile node.args.first})"
          else
            name = ADDITIONAL_OPERATORS.has_key?(node.name) ? ADDITIONAL_OPERATORS[node.name] : node.name
            "(#{transpile node.obj}.#{name}(#{node.args.map { |x| transpile x }.join(", ")})"
          end
        else
          if @@macros.has_key? node.name
            @@macros[node.name].call self, node
          else
            "#{node.name}(#{node.args.map { |x| transpile x }.join(",")})"
          end
        end
      end
    end
  end
end