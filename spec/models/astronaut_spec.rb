require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe "#average_age" do
    it 'returns the average age of the astronauts' do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 82, job: "Commander")
      yuri = Astronaut.create!(name: "Yuri Gagarin", age: 56, job: "Engineer")
      alan = Astronaut.create!(name: "Alan Shepard", age: 70, job: "Pilot")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 78, job: "Co-Pilot")

      expect(Astronaut.average_age).to eq(71.5)
    end
  end
end
