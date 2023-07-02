class Recipe < ApplicationRecord
    belongs_to :user
    #title must be present
    #instructions must be present and at least 50 characters long
    validates :title, presence: true
    validates :instructions, presence: true, length: { minimum: 50 }
end
