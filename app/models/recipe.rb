class Recipe < ApplicationRecord
  validates :title, :recipe_type, :cuisine_id, :difficulty,
            :cook_time, :ingredients, :method, presence: true
  belongs_to :cuisine
end
