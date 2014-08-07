require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'doctors_office'})

class Doctor

  attr_accessor(:id, :name, :insurance_id, :specialty_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @insurance_id = attributes[:insurance_id]
    @specialty_id = attributes[:specialty_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      insurance_id = result['insurance_id'].to_i
      specialty_id = result['specialty_id'].to_i
      id = result['id'].to_i
      doctors << Doctor.new({:name => name, :insurance_id => insurance_id, :specialty_id => specialty_id, :id => id })
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, insurance_id, specialty_id) VALUES ('#{@name}', #{@insurance_id}, #{@specialty_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.id == another_doctor.id
  end

  def self.search_by_name(name)
    Doctor.all.detect { |doctor| doctor.name == name }.id
  end

  def update_name(new_name, old_name)
   found_id = Doctor.search_by_name(old_name)
   DB.exec("UPDATE doctors SET name = '#{new_name}' WHERE id = #{found_id};")
   self.name = new_name
  end

  def self.search_for_object(name)
    Doctor.all.detect { |doctor| doctor.name == name }
  end

  def update_insurance(doctor_name, new_insurance_id)
    found_id = Doctor.search_by_name(doctor_name)
    DB.exec("UPDATE doctors SET insurance_id = #{new_insurance_id} WHERE id = #{found_id};")
    self.insurance_id = new_insurance_id
  end

  def delete_doctor(name)
    doctor = Doctor.search_by_name(name)
    DB.exec("DElETE FROM doctors WHERE id = #{doctor};")
    Doctor.all.delete(Doctor.all.first)
  end

  def self.count_patients(name)
    id = Doctor.search_by_name(name)
    result = DB.exec("SELECT COUNT (*) FROM patients WHERE doctor_id = #{id};")
    result.first['count'].to_i
  end

  def self.sum(name, from, to)
    id = Doctor.search_by_name(name)
    result = DB.exec("SELECT SUM (cost) FROM appointments WHERE doctor_id = #{id} AND date BETWEEN '#{from}' AND '#{to}';")
    result.first['sum'].to_i

  end



end
