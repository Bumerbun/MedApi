class PatientsControllerTest < ActionDispatch::IntegrationTest
  test "patient creation" do
    new_patient_data = patients(:one).as_json
    new_patient_data[:phone] = "+70000000000"
    new_patient_data[:email] = "test@example.com"

    post "/api/patients", params: new_patient_data

    assert_response :success
    assert_equal 201, @response.status

    new_patient_data.delete("id")
    patient = Patient.find_by(new_patient_data)
    assert_not_nil patient
  end

  test "duplicate email" do
    new_patient_data = patients(:one).as_json
    new_patient_data[:email] = "example@example.com"

    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end

  test "invalid email" do
    new_patient_data = patients(:one).as_json
    new_patient_data[:email] = "1234"

    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end

  test "duplicate phone" do
    new_patient_data = patients(:one).as_json
    new_patient_data[:phone] = "+70000000000"

    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end

  test "invalid phone (too long)" do
    new_patient_data = patients(:one).as_json
    new_patient_data[:phone] = "+7000000000099"
    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end

  test "invalid phone (invalid prefix)" do
    new_patient_data = patients(:one).as_json
    new_patient_data[:phone] = "-89999999999"

    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end
  test "missing attributes" do
    new_patient_data = {
      name: "name",
      email: "test@test.com"}

    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end

  test "empty attributes" do
    new_patient_data = {
      name: "",
      surname: "",
      patronymic: "",
      phone: "",
      email: ""}
    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end

  test "invalid name data" do
    new_patient_data = {
      name: "",
      surname: "",
      patronymic: "",
      phone: "+79009009090",
      email: "test@example.com"}
    post "/api/patients", params: new_patient_data

    assert_response :bad_request
  end
end