class ConsultationRecommendationControllerTest < ActionDispatch::IntegrationTest
  test "recommendation creation" do
    request_id = consultation_requests(:one).id
    recommendation_data = {consultation_request_id: request_id, text: "your mining rubies appointment is scheduled on tomorrow 8am"}
    post "/api/consultation_requests/#{request_id}/recommendations", params: recommendation_data

    assert_response :success
    assert_equal 201, @response.status
    recommendation = RequestRecommendation.find_by(recommendation_data)
    assert_not_nil recommendation
    assert_equal "SUCCESS", @response.body[:email_status], @response.body.as_json
  end

  test "invalid request" do
    recommendation_data = {consultation_request_id: -1, text: "i cant help with rubies if you do not exist..."}
    post "/api/consultation_requests/#{recommendation_data[:consultation_request_id]}/recommendations", params: recommendation_data

    assert_response :bad_request
  end

  test "no data" do
    recommendation_data = {}
    post "/api/consultation_requests//recommendations", params: recommendation_data

    assert_response :bad_request
  end

  test "no text" do
    recommendation_data = {consultation_request_id: consultation_requests(:one).id}
    post "/api/consultation_requests/#{recommendation_data[:consultation_request_id]}/recommendations", params: recommendation_data

    assert_response :bad_request
  end

  test "empty text" do
    recommendation_data = {consultation_request_id: consultation_requests(:one).id, text: ""}
    post "/api/consultation_requests/#{recommendation_data[:consultation_request_id]}/recommendations", params: recommendation_data

    assert_response :success
  end

end