class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement

  validates :content, presence: {
    message: "Un message doit être renseigné !"
  }
end
