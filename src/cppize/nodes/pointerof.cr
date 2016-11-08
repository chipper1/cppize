module Cppize
  class Transpiler
    protected def transpile(node : PointerOf, should_return : Bool = false)
      try_tr node {"Crystal::pointerof(#{transpile node.exp})"}
    end
  end
end
