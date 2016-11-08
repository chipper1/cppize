module Cppize
  class Transpiler
    def transpile(node : Include, s : Bool = false)
      if @in_class
        ""
      else
        try_tr(node){"using namespace #{transpile node.name}"}
      end
    end
  end
end
