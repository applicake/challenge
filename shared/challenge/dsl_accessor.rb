module Challenge
  module DslAccessor
    def dsl_accessor(*args)
      args.each do |arg|
        class_eval <<-STR
          def #{arg}(value = nil, &block)
            (value or block) ? @#{arg} = (value || block) : @#{arg}
          end
        STR
      end
    end
  end
end