require 'rspec'
require 'pg'
require 'doctor'
require 'specialty'
require 'patient'
require 'insurance'


describe "Doctor" do
  it "initializes doctors with names, id, specialty_id " do
    test_doctor = Doctor.new({:id => 1, :name => "Dr. Doom", :insurance_id => nil, :specialty_id => nil})
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it "lets you read doctors' name" do
    test_doctor = Doctor.new({:id => 1, :name => "Dr. Doom"})
    expect(test_doctor.name).to eq "Dr. Doom"
  end
end

describe 'Specialty' do
  it "initializes specialties with an id, name" do
    test_specialty = Specialty.new({:id => 1, :name => "surgery"})
    expect(test_specialty).to be_an_instance_of Specialty
  end

  it "lets you read specialty's name" do
    test_specialty = Specialty.new({:id => 1, :name => "surgery"})
    expect(test_specialty.name).to eq "surgery"
  end
end

describe 'Patient' do
  it "initializes patients with an id, name, birthdate" do
    test_patient = Patient.new({:id => 1, :name => "Bob", :birthdate => '1900-01-01', :doctor_id => nil })
    expect(test_patient).to be_an_instance_of Patient
  end

  it "lets you read patients' name and birthdate" do
    test_specialty = Patient.new({:id => 1, :name => "Bob", :birthdate => '1900-01-01', :doctor_id => nil})
    expect(test_specialty.name).to eq "Bob"
    expect(test_specialty.birthdate).to eq "1900-01-01"
  end
end

describe 'Insurance' do
  it "initializes a company with a name" do
    test_insurance = Insurance.new({:id => 1, :name => "Providence"})
    expect(test_insurance).to be_an_instance_of Insurance
  end

  it "lets you read company's name" do
    test_insurance = Insurance.new({:id => 1, :name => "Providence"})
    expect(test_insurance.name).to eq "Providence"
  end
end
