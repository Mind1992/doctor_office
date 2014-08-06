require 'spec_helper'

describe 'Specialty' do
  it "initializes specialties with an id, name" do
    test_specialty = Specialty.new({:id => 1, :name => "surgery"})
    expect(test_specialty).to be_an_instance_of Specialty
  end

  it "lets you read specialty's name" do
    test_specialty = Specialty.new({:id => 1, :name => "surgery"})
    expect(test_specialty.name).to eq "surgery"
  end

  it "starts with no specialties" do
    expect(Specialty.all).to eq []
  end

  it 'lets you save specialties to the database' do
    test_specialty = Specialty.new({:name => "Surgery"})
    test_specialty.save
    expect(Specialty.all).to eq [test_specialty]
  end

  it "lets you search by name and get the id" do
    test_sp = Specialty.new({:name => "surgery"})
    test_sp_2 = Specialty.new({:name => "plastic"})
    test_sp.save
    test_sp_2.save
    expect(Specialty.search_by_name('surgery')).to eq test_sp.id
  end

  # it "lets you search by specialty id and get the specialty name" do
  #   test_specialty = Specialty.new({:name => "surgery"})
  #   test_specialty.save
  #   expect(Specialty.search_by_id()).to eq test_specialty.name
  # end
end
