class Patient < ActiveRecord::Base
  include PgSearch

  # Surgery is the join table for patients and hospitals
  has_many :surgeries
  has_many :hospitals, -> {distinct}, through: :surgeries

  # Client is the join table for patients and users
  has_many :clients
  has_many :users, -> {distinct}, through: :clients

  validates :name, presence: true,
                   uniqueness: { scope: [:age, :gender] }
  validates :age, :gender, presence: true


  accepts_nested_attributes_for :surgeries
  accepts_nested_attributes_for :clients

  # Birthday gem to get the age and other methods
  acts_as_birthday :birthday

  pg_search_scope :search, against: :name, using: {tsearch: {prefix: true, dictionary: "english"} }

  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end

end
