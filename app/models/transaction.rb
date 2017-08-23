class Transaction < ApplicationRecord
	enum entry_type: [:credit, :debit]
end
