

module RuboCop
  module Cop
    module Style
      # This cop checks for the presence of `method_missing` without also
      # defining `respond_to_missing?`.
      #
      # @example
      #   #bad
      #   def method_missing(name, *args)
      #     # ...
      #   end
      #
      #   #good
      #   def respond_to_missing?(name, include_private)
      #     # ...
      #   end
      #
      #   def method_missing(name, *args)
      #     # ...
      #   end
      #
      class MissingRespondToMissing < Cop
        MSG =
          'When using `method_missing`, define `respond_to_missing?`.'

        def on_def(node)
          return unless node.method?(:method_missing)
          return if implements_respond_to_missing?(node)

          add_offense(node)
        end
        alias on_defs on_def

        private

        def implements_respond_to_missing?(node)
          node.parent.each_child_node(node.type).any? do |sibling|
            sibling.method?(:respond_to_missing?)
          end
        end
      end
    end
  end
end
