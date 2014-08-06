require 'spec_helper'

describe 'Insurance' do
  it "initializes a company with a name" do
    test_insurance = Insurance.new({:id => 1, :name => "Providence"})
    expect(test_insurance).to be_an_instance_of Insurance
  end

  it "lets you read company's name" do
    test_insurance = Insurance.new({:id => 1, :name => "Providence"})
    expect(test_insurance.name).to eq "Providence"
  end

  it "starts with no insurance companies" do
    expect(Insurance.all).to eq []
  end

  it 'lets you save insurance companies to the database' do
    test_insurance = Insurance.new({:name => "Providence"})
    test_insurance.save
    expect(Insurance.all).to eq [test_insurance]
  end
end
