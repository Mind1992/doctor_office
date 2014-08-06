class Specialty

  attr_accessor(:id, :name)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end

  def self.all
    results = DB.exec("SELECT * FROM specialties;")
    specialties =[]
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialties <<Specialty.new({:name => name, :id => id})
    end
    specialties
  end

  def save
    results = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_specialty)
    self.name == another_specialty.name && self.id == another_specialty.id
  end

end
