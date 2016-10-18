class BookTour < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  validates :people_number, presence: true

  def paypal_url return_path
    values = {
      business: "business@vovanhai.com",
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      notify_url: "#{Rails.application.secrets.app_host}/update",
      invoice: id,
      cmd: "_xclick",
      amount: tour.price * people_number,
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" +
      values.to_query
  end
end
