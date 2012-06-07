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
      class_eval <<-EOS, __FILE__, __LINE__ + 1
        attr_accessible :#{name}
        def #{name};        eav_attr_model('#{name}', '#{type}').value         end
        def #{name}=(value) eav_attr_model('#{name}', '#{type}').value = value end
        def #{name}?;       eav_attr_model('#{name}', '#{type}').value?        end
      EOS
    end
  end
end
