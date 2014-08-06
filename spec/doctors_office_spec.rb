require 'rspec'
require 'pg'
require 'doctor'

describe "Doctor" do
  it "initializes doctors with names and id" do
    test_doctor = Doctor.new({:id => 1, :name => "Dr. Doom"})
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it "lets you read doctors' name" do
    test_doctor = Doctor.new({:id => 1, :name => "Dr. Doom"})
    expect(test_doctor.name).to eq "Dr. Doom"
  end
end

describe 'Specialty' do
  it "initializes specialties with an id, name, doctor_id" do
    test_specialty = Specialty.new({:id => 1, :name => "surgery", :doctor_id => nil})
    expect(test_specialty).to be_an_instance_of Specialty
  end
end
