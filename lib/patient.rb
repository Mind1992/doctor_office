class Patient

  attr_accessor(:id, :name, :birthdate, :doctor_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @birthdate = attributes[:birthdate]
    @doctor_id = attributes[:doctor_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients =[]
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      patients <<Patient.new({:name => name, :id => id})
    end
    patients
  end

  def save
    results = DB.exec("INSERT INTO patients (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name && self.id == another_patient.id
  end

end
