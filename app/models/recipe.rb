class Recipe < ApplicationRecord
  validates :title, :recipe_type_id, :cuisine_id, :difficulty,
            :cook_time, :ingredients, :method, presence: true
  belongs_to :cuisine
  belongs_to :recipe_type
end
