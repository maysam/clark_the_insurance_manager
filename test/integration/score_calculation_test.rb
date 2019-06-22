require 'test_helper'

class ScoreCalculationTest < ActionDispatch::IntegrationTest
  test "scores are calculated correctly" do
    desired_output = { A: 1.75, B: 1.5, C: 1 }
    input_file = 'testinput.txt'

    post invitations_calculate_score_url, params: { file: fixture_file_upload("files/#{input_file}") }

    assert_response :success

    received_output = JSON.parse response.body
    assert_equal received_output.symbolize_keys, desired_output
  end
end
