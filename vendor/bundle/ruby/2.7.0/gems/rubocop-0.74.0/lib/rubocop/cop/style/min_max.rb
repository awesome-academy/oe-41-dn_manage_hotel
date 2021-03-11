

module RuboCop
  module Cop
    module Style
      # This cop checks for potential uses of `Enumerable#minmax`.
      #
      # @example
      #
      #   # bad
      #   bar = [foo.min, foo.max]
      #   return foo.min, foo.max
      #
      #   # good
      #   bar = foo.minmax
      #   return foo.minmax
      class MinMax < Cop
        MSG = 'Use `%<receiver>s.minmax` instead of `%<offender>s`.'

        def on_array(node)
          min_max_candidate(node) do |receiver|
            offender = offending_range(node)

            add_offense(node, location: offender,
                              message: message(offender, receiver))
          end
        end
        alias on_return on_array

        def autocorrect(node)
          receiver = node.children.first.receiver

          lambda do |corrector|
            corrector.replace(offending_range(node),
                              "#{receiver.source}.minmax")
          end
        end

        private

        def_node_matcher :min_max_candidate, <<~PATTERN
          ({array return} (send [$_receiver !nil?] :min) (send [$_receiver !nil?] :max))
        PATTERN

        def message(offender, receiver)
          format(MSG, offender: offender.source,
                      receiver: receiver.source)
        end

        def offending_range(node)
          case node.type
          when :return
            argument_range(node)
          else
            node.loc.expression
          end
        end

        def argument_range(node)
          first_argument_range = node.children.first.loc.expression
          last_argument_range  = node.children.last.loc.expression

          first_argument_range.join(last_argument_range)
        end
      end
    end
  end
end
