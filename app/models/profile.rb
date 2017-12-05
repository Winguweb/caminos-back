class Profile < ApplicationRecord
  belongs_to :user

  def full_name
    @full_name ||= [first_name, last_name].join(' ').strip
  end

  def initials
    @initial ||= full_name.scan(/(.{1})[a-zA-ZñÑ]*\s*/).join.upcase
  end
end
