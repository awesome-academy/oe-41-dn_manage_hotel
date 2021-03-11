

module RuboCop
  module Cop
    module Style
      # This cop checks for the use of randomly generated numbers,
      # added/subtracted with integer literals, as well as those with
      # Integer#succ and Integer#pred methods. Prefer using ranges instead,
      # as it clearly states the intentions.
      #
      # @example
      #   # bad
      #   rand(6) + 1
      #   1 + rand(6)
      #   rand(6) - 1
      #   1 - rand(6)
      #   rand(6).succ
      #   rand(6).pred
      #   Random.rand(6) + 1
      #   Kernel.rand(6) + 1
      #   rand(0..5) + 1
      #
      #   # good
      #   rand(1..6)
      #   rand(1...7)
      class RandomWithOffset < Cop
        MSG = 'Prefer ranges when generating random numbers instead of ' \
          'integers with offsets.'

        def_node_matcher :integer_op_rand?, <<~PATTERN
          (send
            int {:+ :-}
            (send
              {nil? (const nil? :Random) (const nil? :Kernel)}
              :rand
              {int irange erange}))
        PATTERN

        def_node_matcher :rand_op_integer?, <<~PATTERN
          (send
            (send
              {nil? (const nil? :Random) (const nil? :Kernel)}
              :rand
              {int irange erange})
            {:+ :-}
            int)
        PATTERN

        def_node_matcher :rand_modified?, <<~PATTERN
          (send
            (send
              {nil? (const nil? :Random) (const nil? :Kernel)}
              :rand
              {int irange erange})
            {:succ :pred :next})
        PATTERN

        def on_send(node)
          return unless integer_op_rand?(node) ||
                        rand_op_integer?(node) ||
                        rand_modified?(node)

          add_offense(node)
        end

        def autocorrect(node)
          lambda do |corrector|
            if integer_op_rand?(node)
              corrector.replace(node.source_range,
                                corrected_integer_op_rand(node))
            elsif rand_op_integer?(node)
              corrector.replace(node.source_range,
                                corrected_rand_op_integer(node))
            elsif rand_modified?(node)
              corrector.replace(node.source_range,
                                corrected_rand_modified(node))
            end
          end
        end

        private

        def_node_matcher :random_call, <<~PATTERN
          {(send (send $_ _ $_) ...)
           (send _ _ (send $_ _ $_))}
        PATTERN

        def corrected_integer_op_rand(node)
          random_call(node) do |prefix_node, random_node|
            prefix = prefix_from_prefix_node(prefix_node)
            left_int, right_int = boundaries_from_random_node(random_node)

            offset = to_int(node.receiver)

            if node.method?(:+)
              "#{prefix}(#{offset + left_int}..#{offset + right_int})"
            else
              "#{prefix}(#{offset - right_int}..#{offset - left_int})"
            end
          end
        end

        def corrected_rand_op_integer(node)
          random_call(node) do |prefix_node, random_node|
            prefix = prefix_from_prefix_node(prefix_node)
            left_int, right_int = boundaries_from_random_node(random_node)

            offset = to_int(node.first_argument)

            if node.method?(:+)
              "#{prefix}(#{left_int + offset}..#{right_int + offset})"
            else
              "#{prefix}(#{left_int - offset}..#{right_int - offset})"
            end
          end
        end

        def corrected_rand_modified(node)
          random_call(node) do |prefix_node, random_node|
            prefix = prefix_from_prefix_node(prefix_node)
            left_int, right_int = boundaries_from_random_node(random_node)

            if %i[succ next].include?(node.method_name)
              "#{prefix}(#{left_int + 1}..#{right_int + 1})"
            elsif node.method?(:pred)
              "#{prefix}(#{left_int - 1}..#{right_int - 1})"
            end
          end
        end

        def_node_matcher :namespace, <<~PATTERN
          {$nil? (const nil? $_)}
        PATTERN

        def prefix_from_prefix_node(node)
          namespace(node) do |namespace|
            [namespace, 'rand'].compact.join('.')
          end
        end

        def boundaries_from_random_node(random_node)
          case random_node.type
          when :int
            [0, to_int(random_node) - 1]
          when :irange
            [to_int(random_node.begin), to_int(random_node.end)]
          when :erange
            [to_int(random_node.begin), to_int(random_node.end) - 1]
          end
        end

        def_node_matcher :to_int, <<~PATTERN
          (int $_)
        PATTERN
      end
    end
  end
end
