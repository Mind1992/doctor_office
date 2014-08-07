require 'rspec'
require 'pg'
require 'doctor'
require 'specialty'
require 'patient'
require 'insurance'
require 'appointment'

DB = PG.connect({:dbname => 'doctors_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM doctors *')
    DB.exec('DELETE FROM insurances *')
    DB.exec('DELETE FROM patients *')
    DB.exec('DELETE FROM specialties *')
    DB.exec('DELETE FROM appointments *')
  end
end
