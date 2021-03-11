

module RuboCop
  module AST
    # A node extension for `int` nodes. This will be used in place of a plain
    # node when the builder constructs the AST, making its methods available to
    # all `int` nodes within RuboCop.
    class IntNode < Node
      include NumericNode
    end
  end
end
