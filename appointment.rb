class Appointment

  attr_accessor(:id, :date, :cost, :doctor_id, :patient_id)

  def initialize(attributes)
    @id = (attributes)[:id]
    @date = (attributes)[:date]
    @cost = (attributes)[:cost]
    @doctor_id = (attributes)[:doctor_id]
    @patient_id = (attributes)[:patient_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM appointments;")
    appointments = []
    results.each do |result|
      date = result['date']
      id = result['id'].to_i
      cost = result['cost'].to_i
      doctor_id = result['doctor_id']
      patient_id = result['patient_id']
      appointments << Appointmnet.new({:date => date, :id => id, :cost => cost, :doctor_id => doctor_id, :patient_id => patient_id })
    end
    appointments
  end

end
