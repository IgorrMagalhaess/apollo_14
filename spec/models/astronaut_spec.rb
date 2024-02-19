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

  describe ".total_time_space" do
    it 'sum the time in all the missions for one astronaut' do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 82, job: "Commander")

      gemini = Mission.create!(title: "Gemini 4", time_in_space: 4)
      skylab = Mission.create!(title: "Skylab", time_in_space: 50)
      apollo = Mission.create!(title: "Apollo 11", time_in_space: 8)

      AstronautMission.create!(mission_id: skylab.id, astronaut_id: neil.id)
      AstronautMission.create!(mission_id: apollo.id, astronaut_id: neil.id)
      AstronautMission.create!(mission_id: gemini.id, astronaut_id: neil.id)

      expect(neil.total_time_space).to eq(62)
    end
  end
end