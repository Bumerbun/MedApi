module Api
  class PatientsController < ApplicationController
    def index
      patients = Patient.all
      render json: patients, status: :ok
    end
  end
end