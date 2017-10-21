require "string_math/version"
require "bigdecimal"
require "bigdecimal/util"

module StringMath
  module FloatMath
    refine Float do
      def empty?
        false
      end
    end
  end

  module NilMath
    refine NilClass do
      using FloatMath

      def +(other)
        if other.empty?
          nil
        else
          other
        end
      end

      def empty?
        true
      end

      def to_d
        self
      end
    end
  end

  module BigDecimalMath
    refine BigDecimal do
      using NilMath
      def +(other)
        if other.empty?
          self
        else
          super(other.to_d)
        end
      end

      def empty?
        false
      end
    end
  end

  module StringMath
    refine String do
      using FloatMath
      using NilMath
      using BigDecimalMath

      def +(other)
        if !empty? && !other.empty?
          to_d + other.to_d
        elsif !empty? && other.empty?
          to_d
        elsif empty? && !other.empty?
          other.to_d
        else # empty? && other.empty?
          nil
        end
      end
    end
  end
end
