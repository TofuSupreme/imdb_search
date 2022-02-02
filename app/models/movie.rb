class Movie < ApplicationRecord
  belongs_to :director

  # Adding syntax for PgSearch

  # NOTE  The pgSearch module
  include PgSearch::Model

  # NOTE Adding a multisearch
  multisearchable against: [:title, :synopsis]

  # NOTE  the pg_search_scope's method name. This is the method you need to call in your controller when you want to search for something.

  pg_search_scope :search_by_title_and_synopsis,
  against: [:title, :synopsis],

  # NOTE searching through association for directors
  # Model name [director], field or association name [first_name, last_name]
  associated_against: {
      director: [ :first_name, :last_name ]
    },
  using: {

    # NOTE similar to @@, this is a full text search
    # NOTE: prefix: true allows partial matches(for the beginning onlys)
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end
