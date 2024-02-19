require 'rails_helper' 

RSpec.describe 'Astronaut Show Page', type: :feature do
   describe 'As a visitor' do
      before(:each) do
         @neil = Astronaut.create!(name: "Neil Armstrong", age: 82, job: "Commander")
         @yuri = Astronaut.create!(name: "Yuri Gagarin", age: 56, job: "Engineer")
         @alan = Astronaut.create!(name: "Alan Shepard", age: 70, job: "Pilot")
         @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 78, job: "Co-Pilot")
         
         @apollo = Mission.create!(name: "Apollo 11", time_in_space: 8)
         @gemini = Mission.create!(name: "Gemini 4", time_in_space: 4)
         @syz = Mission.create!(name: "Soyuz 11", time_in_space: 8)
         @skylab = Mission.create!(name: "Skylab", time_in_space: 50)
      

         AstronautMission.create!(mission_id: @apollo.id, astronaut_id: @neil.id)
         AstronautMission.create!(mission_id: @apollo.id, astronaut_id: @alan.id)
         AstronautMission.create!(mission_id: @apollo.id, astronaut_id: @buzz.id)
         AstronautMission.create!(mission_id: @gemini.id, astronaut_id: @neil.id)
         AstronautMission.create!(mission_id: @gemini.id, astronaut_id: @buzz.id)
         AstronautMission.create!(mission_id: @syz.id, astronaut_id: @yuri.id)
         AstronautMission.create!(mission_id: @skylab.id, astronaut_id: @neil.id)
         AstronautMission.create!(mission_id: @skylab.id, astronaut_id: @alan.id)
      end

      it 'has a list of astronauts with its names, age and job' do
         visit "/astronauts"

         within "#astronaut-#{@neil.id}" do
            expect(page).to have_content("Neil Armstrong")
            expect(page).to have_content("Age: 82")
            expect(page).to have_content("Position: Commander")
         end

         within "#astronaut-#{@yuri.id}" do
            expect(page).to have_content("Yuri Gagarin")
            expect(page).to have_content("Age: 56")
            expect(page).to have_content("Position: Engineer")
         end

         within "#astronaut-#{@alan.id}" do
            expect(page).to have_content("Alan Shepard")
            expect(page).to have_content("Age: 70")
            expect(page).to have_content("Position: Pilot")
         end

         within "#astronaut-#{@neil.id}" do
            expect(page).to have_content("Buzz Aldrin")
            expect(page).to have_content("Age: 78")
            expect(page).to have_content("Position: Co-Pilot")
         end
      end

      it 'displays the average age for all astronauts' do
         visit "/astronauts"

         expect(page).to have_content("Average Age of Astronauts: 71.5 years old")
      end
   end
end