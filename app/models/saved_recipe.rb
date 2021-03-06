class SavedRecipe < ApplicationRecord
  belongs_to :user

  validates :recipe_id, uniqueness: { scope: :user, message: 'already a favourite'}, presence: true

end
