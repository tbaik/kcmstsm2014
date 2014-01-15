class Finance < ActiveRecord::Base
  attr_accessible :audit, :cash_amount, :check_amount, :check_number, :data_entry, :date, :notes, :supporter_name, :user_id
  belongs_to :user
  validates :user_id, presence: true
end
