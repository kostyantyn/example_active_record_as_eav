class Product < ActiveRecord::Base
  %w(string integer float boolean).each do |type|
    has_many :"#{type}_attributes", as: :entity, autosave: true, dependent: :delete_all
  end

  def eav_attr_model(name, type)
    attributes = send("#{type}_attributes")
    attributes.detect { |attr| attr.name == name } || attributes.build(name: name)
  end

  class << self
    def eav(name, type)
      attr_accessor name

      attribute_method_matchers.each do |matcher|
        class_eval <<-EOS, __FILE__, __LINE__ + 1
          def #{matcher.method_name(name)}(*args)
            eav_attr_model('#{name}', '#{type}').send :#{matcher.method_name('value')}, *args
          end
        EOS
      end
    end

    def scoped(options = nil)
      super(options).extend(QueryMethods)
    end
  end

  module QueryMethods
    def select(*args, &block)
      super(*args, &block)
    end

    def group(*args)
      super(*args)
    end

    def order(*args)
      super(*args)
    end

    def reorder(*args)
      super(*args)
    end

    def where(*args)
      super(*args)
    end
  end
end
