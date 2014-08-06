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
    puts "10: exit"
    input = gets.chomp
    case input
      when '1' then add_specialty
      when '2' then add_insurance
      when '3' then add_doctor
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

main_menu
