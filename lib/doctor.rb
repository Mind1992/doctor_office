class Doctor

  attr_accessor(:id, :name, :insurance_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @insurance_id = attributes[:insurance_id]
  end



end
