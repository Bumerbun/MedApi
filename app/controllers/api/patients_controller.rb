module Api
  class PatientsController < ApplicationController
    VALIDATOR = PatientContract.new
    def index
      patients = Patient.all
      render json: { status: "SUCCESS", data: patients }, status: :ok
    end

    def create
      final_json = CreationHelper.create(patient_params.to_h, Patient, VALIDATOR).result
      render json: final_json[:data], status: final_json[:status]
    end

    def patient_params
      params.permit(:name, :surname, :patronymic, :phone, :email)
    end
  end
end