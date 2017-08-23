class Transaction < ApplicationRecord
	belongs_to :pickup
	enum entry_type: [:credit, :debit]
end
