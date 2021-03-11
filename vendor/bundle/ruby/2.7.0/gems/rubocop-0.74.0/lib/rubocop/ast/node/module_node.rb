

module RuboCop
  module AST
    # A node extension for `module` nodes. This will be used in place of a
    # plain node when the builder constructs the AST, making its methods
    # available to all `module` nodes within RuboCop.
    class ModuleNode < Node
      # The identifer for this `module` node.
      #
      # @return [Node] the identifer of the module
      def identifier
        node_parts[0]
      end

      # The body of this `module` node.
      #
      # @return [Node, nil] the body of the module
      def body
        node_parts[1]
      end
    end
  end
end
