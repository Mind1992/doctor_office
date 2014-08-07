require 'pg'
require './lib/doctor'
require './lib/specialty'
require './lib/patient'
require './lib/insurance'
require './lib/appointment'
require 'pry'

PG.connect({:dbname => 'doctors_office'})

def main_menu
  loop do
    puts "*** Commands ***"
    puts "1: add specialty"
    puts "2. add insurance company"
    puts "3: add doctor"
    puts "4: add patient"
    puts "5: find doctors by specialty"
    puts "6: find doctors by insurance"
    puts "7: list all doctors"
    puts "8: update doctors' names"
    puts "9: update doctors insurance"
    puts "10: delete doctor"
    puts "11: count patients for a specific doctor"
    puts "12: set an appointment"
    puts "15: exit"
    input = gets.chomp
    case input
      when '1' then add_specialty
      when '2' then add_insurance
      when '3' then add_doctor
      when '4' then add_patient
      when '5' then find_by_specialty
      when '6' then find_by_insurance
      when '7' then list_doctors
      when '8' then update_doctor
      when '9' then update_insurance
      when '10' then delete_doctor
      when '11' then count_patients
      when '12' then set_appointment
      when '15' then exit
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
  puts "New doctor #{new_doctor.name} was added"
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

def find_by_insurance
  p "Insurance: "; input_insurance = gets.chomp
  company_id = Insurance.search_by_name(input_insurance)
  array =[]
  Doctor.all.each do |doctor|
    if doctor.insurance_id == company_id
      array << doctor.name
    end
    puts array
  end
end

def list_doctors
  puts "*** Doctors ***"
  Doctor.all.each do |doctor|
    puts doctor.name
  end
end

def update_doctor
  list_doctors
  puts "Whose name do you want to change?"
  old_name = gets.chomp
  puts "What do you want to change it to?"
  new_name = gets.chomp
  doctor_object = Doctor.search_for_object(old_name)
  doctor_object.update_name(new_name, old_name)
  list_doctors
end

def update_insurance
  list_doctors
  puts "Whose insurance do you want to change?"
  name = gets.chomp
  doctor_object = Doctor.search_for_object(name)
  puts "Current insurance for #{doctor_object.name} is #{doctor_object.insurance_id}"
  list_insurance
  puts "What insurance do you want to substitute to?"
  new_insurance = gets.chomp
  new_insurance_id = Insurance.search_by_name(new_insurance)
  doctor_object.update_insurance(name, new_insurance_id)
  puts "*** Doctors ***"
  Doctor.all.each do |doctor|
    puts doctor.name + " " + doctor.insurance_id.to_s
  end
end

def list_insurance
   puts "*** Insurance ***"
  Insurance.all.each do |name|
    puts name.name
  end
end

def delete_doctor
  list_doctors
  puts "Which doctor do you want to remove?"
  name = gets.chomp
  doctor_object = Doctor.search_for_object(name)
  doctor_object.delete_doctor(name)
  list_doctors
end

def count_patients
  list_doctors
  puts "Choose the doctor?"
  name = gets.chomp
  count = Doctor.count_patients(name)
  puts count
end

def set_appointment
  p "Doctor name: "; doctor_name = gets.chomp
  p "Patient name: "; patient_name = gets.chomp
  p "Date: "; date = gets.chomp
  p "Cost: "; cost = gets.chomp
  doctor_id = Doctor.search_by_name(doctor_name)
  patient_id = Patient.search_by_name(patient_name)
  new_appointment = Appointment.new({:date => date,:cost => cost, :doctor_id => doctor_id, :patient_id => patient_id})
  new_appointment.save
  puts "New appointment was added"
end
main_menu
