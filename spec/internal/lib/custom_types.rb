module CustomTypes
  include Dry::Types.module

  ZeroBox = Coercible::Int.default(0)
end
