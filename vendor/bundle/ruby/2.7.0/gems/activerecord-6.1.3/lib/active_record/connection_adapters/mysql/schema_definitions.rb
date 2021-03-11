

module ActiveRecord
  module ConnectionAdapters
    module MySQL
      module ColumnMethods
        extend ActiveSupport::Concern

        ##
        # :method: blob
        # :call-seq: blob(*names, **options)

        ##
        # :method: tinyblob
        # :call-seq: tinyblob(*names, **options)

        ##
        # :method: mediumblob
        # :call-seq: mediumblob(*names, **options)

        ##
        # :method: longblob
        # :call-seq: longblob(*names, **options)

        ##
        # :method: tinytext
        # :call-seq: tinytext(*names, **options)

        ##
        # :method: mediumtext
        # :call-seq: mediumtext(*names, **options)

        ##
        # :method: longtext
        # :call-seq: longtext(*names, **options)

        ##
        # :method: unsigned_integer
        # :call-seq: unsigned_integer(*names, **options)

        ##
        # :method: unsigned_bigint
        # :call-seq: unsigned_bigint(*names, **options)

        ##
        # :method: unsigned_float
        # :call-seq: unsigned_float(*names, **options)

        ##
        # :method: unsigned_decimal
        # :call-seq: unsigned_decimal(*names, **options)

        included do
          define_column_methods :blob, :tinyblob, :mediumblob, :longblob,
            :tinytext, :mediumtext, :longtext, :unsigned_integer, :unsigned_bigint,
            :unsigned_float, :unsigned_decimal
        end
      end

      class TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
        include ColumnMethods

        attr_reader :charset, :collation

        def initialize(conn, name, charset: nil, collation: nil, **)
          super
          @charset = charset
          @collation = collation
        end

        def new_column_definition(name, type, **options) # :nodoc:
          case type
          when :virtual
            type = options[:type]
          when :primary_key
            type = :integer
            options[:limit] ||= 8
            options[:primary_key] = true
          when /\Aunsigned_(?<type>.+)\z/
            type = $~[:type].to_sym
            options[:unsigned] = true
          end

          super
        end

        private
          def aliased_types(name, fallback)
            fallback
          end

          def integer_like_primary_key_type(type, options)
            options[:auto_increment] = true
            type
          end
      end

      class Table < ActiveRecord::ConnectionAdapters::Table
        include ColumnMethods
      end
    end
  end
end
