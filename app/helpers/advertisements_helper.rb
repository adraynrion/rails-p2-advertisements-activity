module AdvertisementsHelper
  def ad_link(ad)
    li_link = "<li><a href='/advertisements/#{ad.id}'>#{ad.title}</a>"
    if !ad.published?
      li_link += " -> Non publiée"
    end

    return li_link.html_safe
  end
end
