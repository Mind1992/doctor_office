class Patient

  attr_accessor(:id, :name, :birthdate, :doctor_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @birthdate = attributes[:birthdate]
    @doctor_id = attributes[:doctor_id]
  end
end
