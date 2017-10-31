class Recipe < ApplicationRecord
  validates :title, :recipe_type_id, :cuisine_id, :difficulty,
            :cook_time, :ingredients, :method, presence: true
  belongs_to :cuisine
  belongs_to :recipe_type

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" },
                  default_url: "/images/:style/sem-foto.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
