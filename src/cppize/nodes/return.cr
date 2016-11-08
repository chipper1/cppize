module Cppize
  class Transpiler
    protected def transpile(node : Return, should_return : Bool = false)
      try_tr(node){"return" + (node.exp ? " #{transpile node.exp}" : "")}
    end
  end
end
