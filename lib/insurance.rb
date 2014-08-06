class Insurance

  attr_accessor(:id,:name,:doctor_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @doctor_id = attributes[:doctor_id]
  end

end
