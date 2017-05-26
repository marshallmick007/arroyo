# Monkeywrenched {Integer} class enabled to compute File Sizes.
# @example
#   4.MB
#     => 4096
class Numeric
  UNIT_BASE = 1024
  @@size_units = [
    { :name => 'KB', weight: UNIT_BASE },
    { :name => 'MB', weight: UNIT_BASE ** 2 },
    { :name => 'GB', weight: UNIT_BASE ** 3 },
    { :name => 'TB', weight: UNIT_BASE ** 4 }
  ]
  
  @@size_units.each do |unit|
    class_eval "
      def #{unit[:name]}
        self * #{unit[:weight]}
      end
    "
  end
end
