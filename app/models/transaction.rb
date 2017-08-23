class Transaction < ApplicationRecord
  belongs_to :user
	enum entry_type: [:credit, :debit]
end
