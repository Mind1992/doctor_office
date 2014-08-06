require 'spec_helper'

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

  it "starts with no patients" do
    expect(Patient.all).to eq []
  end

  it 'lets you save patients to the database' do
    test_patient = Patient.new({:name => "Mr. Jones"})
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

end
