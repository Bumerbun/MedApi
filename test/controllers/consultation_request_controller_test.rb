class ConsultationRequestControllerTest < ActionDispatch::IntegrationTest
  test "consultation request creation" do
    patient_id = patients(:one).id
    request_data = {patient_id: patient_id, text: "i request rubies"}
    post "/api/consultation_requests", params: request_data
    assert_response :success
    assert_equal 201, @response.status
    request = ConsultationRequest.find_by(request_data)
    assert_not_nil request
  end

  test "invalid patient" do
    request_data = {patient_id: -1, text: "i request rubies"}
    post "/api/consultation_requests", params: request_data
    assert_response :bad_request
  end

  test "no data" do
    request_data = {}
    post "/api/consultation_requests", params: request_data
    assert_response :bad_request
  end
end