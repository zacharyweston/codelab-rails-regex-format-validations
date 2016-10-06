class Post < ActiveRecord::Base

  # validates :title,   presence: true
  # validates :content, presence: true
  # validates :name,    presence: true

  validate :flurb_regex

  def flurb_regex
    flurb_regex = (/\A.*fl\S{1,}rb.*\z/i)
    if title =~ flurb_regex
      errors.add(:title, (%("can't include the word "flurb" or a variation thereof"))
    end
    if content =~ flurb_regex
      errors.add(:content, "can't include the word 'flurb' or a variation thereof")
    end
  end
end
