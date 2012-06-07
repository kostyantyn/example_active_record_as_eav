class Attribute < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :name, :value

  belongs_to :entity, polymorphic: true, touch: true, autosave: true
end