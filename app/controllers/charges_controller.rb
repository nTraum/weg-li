class ChargesController < ApplicationController
  def index
    @charges = Charge.active.order(params[:order] || 'tbnr ASC').page(params[:page])
    @charges = @charges.where('tbnr ILIKE :term OR description ILIKE :term', term: "%#{params[:term]}%") if params[:term]
  end

  def show
    @charge = Charge.active.from_param(params[:id])
  end

  def list
    respond_to do |format|
      format.csv do
        csv_data = CSV.generate(force_quotes: true) do |csv|
          csv << ["ID","Tatbestand"]
          Vehicle.charges.each_with_index { |charge, index| csv << [index + 1, charge] }
        end
        send_data csv_data, type: 'text/csv; charset=UTF-8; header=present', disposition: "attachment; filename=districts-#{Time.now.to_i}.csv"
      end
    end
  end
end
