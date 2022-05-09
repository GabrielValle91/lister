class List < ApplicationRecord
    belongs_to :user
    has_many :list_items

    accepts_nested_attributes_for :list_items, :allow_destroy => true
end
