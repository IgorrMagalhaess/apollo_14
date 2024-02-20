require 'rails_helper'

RSpec.describe "Astronaut Show Page" do
   describe "as a visitor" do
      before(:each) do
         @neil = Astronaut.create!(name: "Neil Armstrong", age: 82, job: "Commander")
         @yuri = Astronaut.create!(name: "Yuri Gagarin", age: 56, job: "Engineer")
         @alan = Astronaut.create!(name: "Alan Shepard", age: 70, job: "Pilot")
         @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 78, job: "Co-Pilot")
         
         @skylab = Mission.create!(title: "Skylab", time_in_space: 50)
         @gemini = Mission.create!(title: "Gemini 4", time_in_space: 4)
         @syz = Mission.create!(title: "Soyuz 11", time_in_space: 8)
         @apollo = Mission.create!(title: "Apollo 11", time_in_space: 8)
      

         AstronautMission.create!(mission_id: @apollo.id, astronaut_id: @neil.id)
         AstronautMission.create!(mission_id: @apollo.id, astronaut_id: @alan.id)
         AstronautMission.create!(mission_id: @apollo.id, astronaut_id: @buzz.id)
         AstronautMission.create!(mission_id: @gemini.id, astronaut_id: @neil.id)
         AstronautMission.create!(mission_id: @gemini.id, astronaut_id: @buzz.id)
         AstronautMission.create!(mission_id: @syz.id, astronaut_id: @yuri.id)
         AstronautMission.create!(mission_id: @skylab.id, astronaut_id: @neil.id)
         AstronautMission.create!(mission_id: @skylab.id, astronaut_id: @alan.id)
      end

      it 'display the name of the astronaut ans the missions the astronaut has been on' do
         visit "/astronauts/#{@neil.id}"

         expect(page).to have_content(@neil.name)
         expect(page).to have_content(@apollo.title)
         expect(page).to have_content(@gemini.title)
         expect(page).to have_content(@skylab.title)
      end

      it 'has a form to add an id of an existing mission to add mission to astronaut' do
         visit "/astronauts/#{@yuri.id}"

         expect(page).to_not have_content(@gemini.title)

         expect(page).to have_content("Add Mission to Astronaut:")
         expect(page).to have_field(:mission_id)
         expect(page).to have_button("Add Mission")

         fill_in(:mission_id, with: @gemini.id)

         click_button("Add Mission")

         expect(current_path).to eq("/astronauts/#{@yuri.id}")
         expect(page).to have_content(@gemini.title)
      end
   end
end