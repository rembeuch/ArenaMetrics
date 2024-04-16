class ReservationsController < ApplicationController
  require 'csv'

  def index
    @reservations = Reservation.all
    @reservations = @reservations.where(show_name: params[:show_name]) if params[:show_name].present?

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

    @average_prices = @reservations.group(:show_name).average(:price)

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
    @reservation_attributes = [
      'ticket_number', 'reservation_number', 'reservation_date', 'reservation_time',
      'show_key', 'show_name', 'representation_key', 'representation_name',
      'representation_date', 'representation_start_time', 'representation_end_date',
      'representation_end_time', 'price', 'product_type', 'sales_channel',
      'last_name', 'first_name', 'email', 'address', 'postal_code', 'country',
      'age', 'gender'
    ]  end

  def import_form
    file = params[:file]
    
    if file.present? && file.content_type == 'text/csv'
      CSV.foreach(file.path, headers: true, col_sep: ';') do |row|
        reservation_params = {
          ticket_number: params["column_mapping"]["0"] != "" ? row[params["column_mapping"]["0"].to_i] : nil,
          reservation_number: params["column_mapping"]["1"] != "" ? row[params["column_mapping"]["1"].to_i] : nil,
          reservation_date: params["column_mapping"]["2"] != "" ? row[params["column_mapping"]["2"].to_i] : nil,
          reservation_time: params["column_mapping"]["3"] != "" ? row[params["column_mapping"]["3"].to_i] : nil,
          show_key: params["column_mapping"]["4"] != "" ? row[params["column_mapping"]["4"].to_i] : nil,
          show_name: params["column_mapping"]["5"] != "" ? row[params["column_mapping"]["5"].to_i] : nil,
          representation_key: params["column_mapping"]["6"] != "" ? row[params["column_mapping"]["6"].to_i] : nil,
          representation_name: params["column_mapping"]["7"] != "" ? row[params["column_mapping"]["7"].to_i] : nil,
          representation_date: params["column_mapping"]["8"] != "" ? row[params["column_mapping"]["8"].to_i] : nil,
          representation_start_time: params["column_mapping"]["9"] != "" ? row[params["column_mapping"]["9"].to_i] : nil,
          representation_end_date: params["column_mapping"]["10"] != "" ? row[params["column_mapping"]["10"].to_i] : nil,
          representation_end_time: params["column_mapping"]["11"] != "" ? row[params["column_mapping"]["11"].to_i] : nil,
          price: params["column_mapping"]["12"] != "" ? row[params["column_mapping"]["12"].to_i] : nil,
          product_type: params["column_mapping"]["13"] != "" ? row[params["column_mapping"]["13"].to_i] : nil,
          sales_channel: params["column_mapping"]["14"] != "" ? row[params["column_mapping"]["14"].to_i] : nil,
          last_name: params["column_mapping"]["15"] != "" ? row[params["column_mapping"]["15"].to_i] : nil,
          first_name: params["column_mapping"]["16"] != "" ? row[params["column_mapping"]["16"].to_i] : nil,
          email: params["column_mapping"]["17"] != "" ? row[params["column_mapping"]["17"].to_i] : nil,
          address: params["column_mapping"]["18"] != "" ? row[params["column_mapping"]["18"].to_i] : nil,
          postal_code: params["column_mapping"]["19"] != "" ? row[params["column_mapping"]["19"].to_i] : nil,
          country: params["column_mapping"]["20"] != "" ? row[params["column_mapping"]["20"].to_i] : nil,
          age: params["column_mapping"]["21"] != "" ? row[params["column_mapping"]["21"].to_i] : nil,
          gender: params["column_mapping"]["22"] != "" ? row[params["column_mapping"]["22"].to_i] : nil
        }
        
        Reservation.create(reservation_params)
      end
      flash[:notice] = "Importation CSV réussie!"
      redirect_to reservations_path
    else
      redirect_to file_path
    end
  end
end
