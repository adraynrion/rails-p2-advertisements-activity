class User < ApplicationRecord
  validates :name, presence: {
    message: "Le nom d'utilisateur doit être renseigné !"
  }
  validates :name, uniqueness: {
    message: "Ce nom d'utilisateur est déjà prit !"
  }

  validates :password, presence: {
    message: "Le mot de passe doit être renseigné !"
  }


  def admin?
    return self.role == "admin"
  end
end
