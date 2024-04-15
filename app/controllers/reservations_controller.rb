class ReservationsController < ApplicationController
  require 'csv'

  def index
    @reservations = Reservation.all

    unique_buyers = @reservations.distinct.pluck(:last_name, :first_name, :email)
    @total_buyers_count = unique_buyers.count
    @ages = []

    unique_buyers.each do |buyer|
      reservations_for_buyer = @reservations.where(last_name: buyer[0], first_name: buyer[1], email: buyer[2])
      buyer_ages = reservations_for_buyer.pluck(:age).compact.uniq
      unless buyer_ages.empty?
        @ages.concat(buyer_ages)
      end
    end

    @average_age = @ages.sum.round / @ages.size unless @ages.empty?

    @average_prices = Reservation.group(:show_name).average(:price)

  end

  def import
    file = params[:file]
    
    if file.present? && file.content_type == 'text/csv'
      CSV.foreach(file.path, headers: true, col_sep: ';') do |row|
        reservation_params = {
          ticket_number: row['Numero billet'],
          reservation_number: row['Reservation'],
          reservation_date: row['Date reservation'],
          reservation_time: row['Heure reservation'],
          show_key: row['Cle spectacle'],
          show_name: row['Spectacle'],
          representation_key: row['Cle representation'],
          representation_name: row['Representation'],
          representation_date: row['Date representation'],
          representation_start_time: row['Heure representation'],
          representation_end_date: row['Date fin representation'],
          representation_end_time: row['Heure fin representation'],
          price: row['Prix'],
          product_type: row['Type de produit'],
          sales_channel: row['Filiere de vente'],
          last_name: row['Nom'],
          first_name: row['Prenom'],
          email: row['Email'],
          address: row['Adresse'],
          postal_code: row['Code postal'],
          country: row['Pays'],
          age: row['Age'],
          gender: row['Sexe']
        }
        
        Reservation.create(reservation_params)
      end
      flash[:notice] = "Importation CSV réussie!"
      redirect_to reservations_path
    else
      redirect_to file_path
    end
  end

  def file

  end
end
