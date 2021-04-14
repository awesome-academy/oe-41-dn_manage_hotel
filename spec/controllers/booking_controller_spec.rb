require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  include SessionsHelper
  let!(:user) {FactoryBot.create(:user)}
  let!(:room_type) {FactoryBot.create(:room_type)}
  let!(:room) {FactoryBot.create(:room, room_type_id: room_type.id)}
  let!(:customer) {FactoryBot.create(:customer)}
  let!(:booking) { FactoryBot.create(:booking, {room_id: room.id, user_id: user.id, customer_id: customer.id})}
  before do
    log_in user
    current_user
  end

  describe "GET #new" do
    context "when user is logged" do
      it "show form booking for signed in user" do
        get :new, params: { use_route: 'rooms/', room_id: room.id}
        expect(response).to be_successful
      end
    end
  end
  describe "POST #create" do
    context "when user is logged" do
      it "create booking susscess for signed in user" do
        post :create, params: { use_route: 'rooms/', room_id: room.id,
          booking: {start_date: "2021-05-15", end_date: "2021-05-16",
            customer_attributes: {name: "abc", birthday: "1990-10-24",address: "dn", id_card: "123456"}}}
        expect(response).to redirect_to(rooms_path)
      end
      it "create booking fails for signed in user" do
        post :create, params: { use_route: 'rooms/', room_id: room.id,
          booking: {start_date: "2021-05-15", end_date: "2021-05-16",
            customer_attributes: FactoryBot.build(:customer)}}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #index" do
    context "when user is logged" do
      it "show bookings for signed in user" do
        get :index, params: { use_route: 'users/', user_id: user.id}
        expect(response).to be_successful
      end
    end
  end

   describe "PUT #cancel_booked" do
    context "when user is logged" do
      it "cancel booked for signed in user" do
        put :cancel_booked, params: { use_route: 'user/', id: booking.id}
        expect(response).to redirect_to(user_bookings_path(user_id: current_user.id))
      end
    end
  end
end
