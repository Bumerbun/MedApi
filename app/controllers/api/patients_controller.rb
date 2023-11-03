module Api
  class PatientsController < ApplicationController
    @@validator = PatientContract.new
    def index
      patients = Patient.all
      render json: { status: "SUCCESS", data: patients }, status: :ok
    end

    def create
      CreationHelper.create(self, patient_params.to_h, Patient, @@validator)
    end

    def patient_params
      params.permit(:name, :surname, :patronymic, :phone, :email)
    end
  end
end