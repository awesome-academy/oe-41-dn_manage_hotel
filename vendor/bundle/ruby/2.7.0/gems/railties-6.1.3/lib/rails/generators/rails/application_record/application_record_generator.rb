

module Rails
  module Generators
    class ApplicationRecordGenerator < Base # :nodoc:
      hook_for :orm, required: true, desc: "ORM to be invoked"
    end
  end
end
