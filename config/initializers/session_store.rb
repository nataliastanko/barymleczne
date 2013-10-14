# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_library_session',
  :secret      => '9b45583d1c9b35d2733a4e8eabb20a50569be09e473780bf50515d099c1eb36354c52b7b4ffd18da0279576d49d9bfd75c5fe47a48bb2e2ce8efbb36768cde46'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
