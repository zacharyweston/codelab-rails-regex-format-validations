class Post < ActiveRecord::Base

  validates :title,   presence: true
  validates :content, presence: true
  validates :name,    presence: true

  validate :flurb_regex

  def flurb_regex
    flurb_regex = (/(fl(a|i|u|e|o|y|\|_\|)rb)/i)
    name_regex = (/[^,\.\- [[:alpha:]]]/)
    if title =~ flurb_regex
      errors.add(:title, "can't include the word \"flurb\" or a variation thereof")
    end
    if content =~ flurb_regex
      errors.add(:content, "can't include the word \"flurb\" or a variation thereof")
    end
    if name =~ name_regex
      errors.add(:name, "isn't a valid name (only letters, spaces, periods, dashes, and commas allowed)")
    end
  end
end
