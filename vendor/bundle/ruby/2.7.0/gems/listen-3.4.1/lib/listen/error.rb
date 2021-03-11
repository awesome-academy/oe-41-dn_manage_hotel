

# Besides programming error exceptions like ArgumentError,
# all public interface exceptions should be declared here and inherit from Listen::Error.
module Listen
  class Error < RuntimeError
    class NotStarted < Error; end
    class SymlinkLoop < Error; end
  end
end