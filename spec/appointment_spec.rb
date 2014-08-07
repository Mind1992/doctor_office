require 'spec_helper'

describe 'Appointment' do
  it "initializes appointment with an id, date, doctor_id, patient_id" do
    test_appointment = Appointment.new({:id => 1, :date => "2014-08-10", :cost => 500, :doctor_id => 1, :patient_id => 1 })
    expect(test_appointment).to be_an_instance_of Appointment
  end

  it "lets you read appointment date and cost" do
    test_appointment = Appointment.new({:id => 1, :date => "2014-08-10", :cost => 500, :doctor_id => 1, :patient_id => 1 })
    expect(test_appointment.date).to eq "2014-08-10"
    expect(test_appointment.cost).to eq 500
  end

  it "starts with no appointments" do
    expect(Appointment.all).to eq []
  end

  it 'lets you save appointment to the database' do
    test_appointment = Appointment.new({:id => 1, :date => "2014-08-10 00:00:00", :cost => 500, :doctor_id => 1, :patient_id => 1 })
    test_appointment.save
    expect(Appointment.all).to eq [test_appointment]
  end

end
