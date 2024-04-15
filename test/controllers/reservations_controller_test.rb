require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should import reservations from CSV" do
    file = fixture_file_upload('test.csv', 'text/csv')
    post import_url, params: { file: file }
    assert_redirected_to reservations_url
    assert_equal "Importation CSV réussie!", flash[:notice]
  end

  def setup
    @file = fixture_file_upload('test.csv', 'text/csv')
    post import_url, params: { file: @file } unless @imported
    @imported = true
  end

  test "should create 99 reservations" do
    assert_equal 99, Reservation.count
  end

  test "should calculate unique buyers count" do
    get reservations_url
    assert_equal Reservation.distinct.count(:last_name), assigns(:total_buyers_count)
  end

  test "should calculate average age" do
    get reservations_url
    assert_not_nil assigns(:average_age)
  end

  test "should calculate average price" do
    get reservations_url
    assert_not_nil assigns(:average_prices)
  end

  test "should calculate 24 for unique buyers count" do
    get reservations_url
    assert_equal 24, assigns(:total_buyers_count)
  end

  test "should calculate 64 average age" do
    get reservations_url
    assert_equal 64, assigns(:average_age) 
  end

  test "should calculate 18.00 average price" do
    get reservations_url
    assert_equal 28.00, assigns(:average_prices)['887'] 
  end
end
