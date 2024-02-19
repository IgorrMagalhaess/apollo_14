require 'rails_helper'

describe Mission, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :time_in_space }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :astronauts}
  end

  describe "#alpha_ordered_missions" do
    it 'returns the missions an astronaut has been in alphabetichal order' do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 82, job: "Commander")

      gemini = Mission.create!(title: "Gemini 4", time_in_space: 4)
      skylab = Mission.create!(title: "Skylab", time_in_space: 50)
      apollo = Mission.create!(title: "Apollo 11", time_in_space: 8)

      AstronautMission.create!(mission_id: skylab.id, astronaut_id: neil.id)
      AstronautMission.create!(mission_id: apollo.id, astronaut_id: neil.id)
      AstronautMission.create!(mission_id: gemini.id, astronaut_id: neil.id)

      expect(neil.missions.alpha_ordered_missions).to eq([apollo, gemini, skylab])
    end
  end
end
