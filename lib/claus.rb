# Santa Claus tells ya if you're naughty or nice.
#
# @example
#   claus = Claus.new(foo: 1, bar: 2)
#   claus.match(foo: 1, bar: 2)           #=> true
#   claus.match(foo: 1, bar: 3)           #=> false
#   claus.match(foo: 1, bar: 2, baz: 3)   #=> true
#
#   claus = Claus.new(foo: 1, bar: 1..2)
#   claus.match(foo: 1, bar: 2)           #=> true
#
#   claus = Claus.new([{foo:1}, {bar:2}])
#   claus.match?(foo: 1)                  #=> true
#   claus.match?(bar: 2)                  #=> true
#   claus.match?(baz: 3)                  #=> false
#
class Claus
  def initialize expression
    @ast = compile(expression)
  end

  def match? value
    @ast.match?(value)
  end

  protected
    def compile expression
      case expression
        when Hash  then AST::Hash.new(expression)
        when Array then AST::List.new(expression)
        else       raise ArgumentError, "invalid expression at #{expression}"
      end
    end

  module AST
    class Node
      attr_reader :ast
      def initialize expression
        @ast = compile(expression)
      end

      def compile expression
        expression
      end

      def match? value
        ast == value
      end
    end # Node

    # TODO: refactor case statements
    class Hash < Node
      def compile expression
        expression.each_with_object({}) do |(k, v), h|
          case v
            when ::Hash   then h[k] = Hash.new(v)
            when ::Array  then h[k] = List.new(v)
            when ::Range  then h[k] = List.new(v)
            else               h[k] = Node.new(v)
          end
        end
      end

      def match? value
        ast.each do |k, node|
          return false unless ::Hash === value && node.match?(value[k])
        end
        true
      end
    end # Hash

    class List < Node
      def compile expression
        expression.map do |v|
          case v
            when ::Hash   then Hash.new(v)
            when ::Array  then List.new(v)
            when ::Range  then List.new(v)
            else               Node.new(v)
          end
        end
      end

      def match? value
        !!ast.find {|node| node.match?(value)}
      end
    end # List
  end # AST
end # Claus
