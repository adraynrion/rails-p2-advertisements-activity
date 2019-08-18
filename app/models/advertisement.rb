class Advertisement < ApplicationRecord
  belongs_to :user

  validates :title, presence: {
    message: "Le titre doit être renseigné !"
  }
  validates :content, presence: {
    message: "Le contenu doit être renseigné !"
  }
  validates :price, presence: {
    message: "Le prix doit être renseigné !"
  }

  def published?
    return self.state == "published"
  end
end
