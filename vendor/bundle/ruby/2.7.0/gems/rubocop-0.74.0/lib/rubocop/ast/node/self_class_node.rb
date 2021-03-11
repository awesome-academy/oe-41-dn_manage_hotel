

module RuboCop
  module AST
    # A node extension for `sclass` nodes. This will be used in place of a
    # plain node when the builder constructs the AST, making its methods
    # available to all `sclass` nodes within RuboCop.
    class SelfClassNode < Node
      # The identifer for this `sclass` node. (Always `self`.)
      #
      # @return [Node] the identifer of the class
      def identifier
        node_parts[0]
      end

      # The body of this `sclass` node.
      #
      # @return [Node, nil] the body of the class
      def body
        node_parts[1]
      end
    end
  end
end