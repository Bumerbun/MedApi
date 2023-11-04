class ConsultationRecommendationControllerTest < ActionDispatch::IntegrationTest

  test "recommendation creation" do
    request_id = consultation_requests(:one).id
    recommendation_data = {consultation_request_id: request_id, text: "your mining rubies appointment is scheduled on tomorrow 8am"}
    post "/api/consultation_requests/#{request_id}/recommendations", params: recommendation_data

    assert_response :success
    assert_equal 201, @response.status
    recommendation = RequestRecommendation.find_by(recommendation_data)
    assert_not_nil recommendation

    body = JSON.parse @response.body
    assert_equal "SUCCESS", body["extra"]["email_status"]
  end

  test "invalid request" do
    recommendation_data = {consultation_request_id: -1, text: "i cant help with rubies if you do not exist..."}
    post "/api/consultation_requests/#{recommendation_data[:consultation_request_id]}/recommendations", params: recommendation_data

    assert_response :conflict
  end

  test "no data" do
    recommendation_data = {}
    post "/api/consultation_requests//recommendations", params: recommendation_data

    assert_response :not_found
  end

  test "no text" do
    recommendation_data = {consultation_request_id: consultation_requests(:one).id}
    post "/api/consultation_requests/#{recommendation_data[:consultation_request_id]}/recommendations", params: recommendation_data

    assert_response :conflict
  end

  test "empty text" do
    recommendation_data = {consultation_request_id: consultation_requests(:one).id, text: ""}
    post "/api/consultation_requests/#{recommendation_data[:consultation_request_id]}/recommendations", params: recommendation_data

    assert_response :conflict
  end

end