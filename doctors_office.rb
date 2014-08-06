require 'pg'
require './lib/doctor'
require './lib/specialty'
require './lib/patient'
require './lib/insurance'

PG.connect({:dbname => 'doctors_office'})

def main_menu
  loop do
    puts "*** Commands ***"
    puts "1: add specialty"
    puts "2. add insurance company"
    puts "3: add doctor"
    puts "4: add patient"
    puts "5: find doctors by specialty"
    puts "10: exit"
    input = gets.chomp
    case input
      when '1' then add_specialty
      when '2' then add_insurance
      when '3' then add_doctor
      when '4' then add_patient
      when '5' then find_by_specialty
      when '10' then exit
    end
  end
end

def add_specialty
  puts "Add specialty."
  input = gets.chomp
  new_specialty = Specialty.new({:name => input})
  new_specialty.save
  Specialty.all.each do |specialty|
    puts specialty.name
    puts specialty.id
  end
end

def add_insurance
  puts "Add insurance company."
  input = gets.chomp
  new_insurance = Insurance.new({:name => input})
  new_insurance.save
  Insurance.all.each do |insurance|
    puts insurance.name
    puts insurance.id
  end
end

def add_doctor
  p "Name: "; name = gets.chomp
  p "Insurance: "; insurance = gets.chomp
  insurance_id = Insurance.search_by_name(insurance)
  p "Specialty: "; specialty = gets.chomp
  specialty_id = Specialty.search_by_name(specialty)
  new_doctor = Doctor.new({:name => name,:insurance_id => insurance_id, :specialty_id => specialty_id})
  new_doctor.save
  Doctor.all.each do |doctor|
    puts doctor.name
    puts doctor.insurance_id
    puts doctor.specialty_id
    puts doctor.id
  end
end

def add_patient
  p "Name: "; name = gets.chomp
  p "Birth date: "; birthdate = gets.chomp
  p "Doctors' name: "; doctor_name = gets.chomp
  doctor_id = Doctor.search_by_name(doctor_name)
  new_patient = Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id})
  new_patient.save
end

def find_by_specialty
  p "Specialty: "; input_specialty = gets.chomp
  specialist_id = Specialty.search_by_name(input_specialty)
  array =[]
  Doctor.all.each do |doctor|
    if doctor.specialty_id == specialist_id
      array << doctor.name
    end
    puts array
  end
end
main_menu
