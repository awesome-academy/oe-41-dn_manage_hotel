

module Arel # :nodoc: all
  module OrderPredications
    def asc
      Nodes::Ascending.new self
    end

    def desc
      Nodes::Descending.new self
    end
  end
end
