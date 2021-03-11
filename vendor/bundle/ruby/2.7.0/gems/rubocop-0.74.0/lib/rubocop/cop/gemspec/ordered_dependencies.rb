

module RuboCop
  module Cop
    module Gemspec
      # Dependencies in the gemspec should be alphabetically sorted.
      #
      # @example
      #   # bad
      #   spec.add_dependency 'rubocop'
      #   spec.add_dependency 'rspec'
      #
      #   # good
      #   spec.add_dependency 'rspec'
      #   spec.add_dependency 'rubocop'
      #
      #   # good
      #   spec.add_dependency 'rubocop'
      #
      #   spec.add_dependency 'rspec'
      #
      #   # bad
      #   spec.add_development_dependency 'rubocop'
      #   spec.add_development_dependency 'rspec'
      #
      #   # good
      #   spec.add_development_dependency 'rspec'
      #   spec.add_development_dependency 'rubocop'
      #
      #   # good
      #   spec.add_development_dependency 'rubocop'
      #
      #   spec.add_development_dependency 'rspec'
      #
      #   # bad
      #   spec.add_runtime_dependency 'rubocop'
      #   spec.add_runtime_dependency 'rspec'
      #
      #   # good
      #   spec.add_runtime_dependency 'rspec'
      #   spec.add_runtime_dependency 'rubocop'
      #
      #   # good
      #   spec.add_runtime_dependency 'rubocop'
      #
      #   spec.add_runtime_dependency 'rspec'
      #
      #   # good only if TreatCommentsAsGroupSeparators is true
      #   # For code quality
      #   spec.add_dependency 'rubocop'
      #   # For tests
      #   spec.add_dependency 'rspec'
      class OrderedDependencies < Cop
        include ConfigurableEnforcedStyle
        include OrderedGemNode

        MSG = 'Dependencies should be sorted in an alphabetical order within ' \
              'their section of the gemspec. '\
              'Dependency `%<previous>s` should appear before `%<current>s`.'

        def investigate(processed_source)
          return if processed_source.blank?

          dependency_declarations(processed_source.ast)
            .each_cons(2) do |previous, current|
            next unless consecutive_lines(previous, current)
            next unless case_insensitive_out_of_order?(
              gem_name(current),
              gem_name(previous)
            )
            unless get_dependency_name(previous) == get_dependency_name(current)
              next
            end

            register_offense(previous, current)
          end
        end

        def autocorrect(node)
          OrderedGemCorrector.correct(
            processed_source,
            node,
            previous_declaration(node),
            treat_comments_as_separators
          )
        end

        private

        def previous_declaration(node)
          declarations = dependency_declarations(processed_source.ast)
          node_index = declarations.find_index(node)
          declarations.to_a[node_index - 1]
        end

        def get_dependency_name(node)
          node.method_name
        end

        def_node_search :dependency_declarations, <<~PATTERN
          (send (lvar _) {:add_dependency :add_runtime_dependency :add_development_dependency} ...)
        PATTERN
      end
    end
  end
end