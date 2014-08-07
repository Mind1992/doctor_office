
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
      appointments << Appointment.new({:id => id, :date => date, :cost => cost, :doctor_id => doctor_id, :patient_id => patient_id })
    end
    appointments
  end

  def save
    results = DB.exec("INSERT INTO appointments (date, cost, doctor_id, patient_id) VALUES ('#{@date}', #{@cost}, #{@doctor_id}, #{patient_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_appointment)
    self.date == another_appointment.date && self.id == another_appointment.id
  end


end
