class Insurance

  attr_accessor(:id,:name,:doctor_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @doctor_id = attributes[:doctor_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM insurances;")
    insurances = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      insurances << Doctor.new({:name => name, :id => id })
    end
    insurances
  end

  def save
    results = DB.exec("INSERT INTO insurances (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_insurance)
    self.name == another_insurance.name && self.id == another_insurance.id
  end
end
