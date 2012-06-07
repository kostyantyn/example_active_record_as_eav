class SimpleProduct < Product
  attr_accessible :name

  eav :code,     :string
  eav :price,    :float
  eav :quantity, :integer
  eav :active,   :boolean
end
