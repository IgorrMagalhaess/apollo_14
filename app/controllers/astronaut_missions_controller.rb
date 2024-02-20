class AstronautMissionsController < ApplicationController
   def create
      astronaut_mission = AstronautMission.create(astronaut_id: params[:id], mission_id: params[:mission_id])
      redirect_to "/astronauts/#{params[:id]}"
   end
end