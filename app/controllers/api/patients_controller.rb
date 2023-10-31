module Api
  class PatientsController < ApplicationController
    def index
      patients = Patient.all
      render json: { status: "SUCCESS", data: patients }, status: :ok
    end

    def create
      patient = Patient.new(patient_params)
      if patient.save
        render json: {status: "SUCCESS", message: "Patient created"}, status: :created
      else
        render json: {status: "FAILURE", message: "Request could not be saved"}, status: :bad_request
      end
    end

    def patient_params
      params.permit(:name, :surname, :patronymic, :phone, :email)
    end
  end
end