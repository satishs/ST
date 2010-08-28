# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MseiQA_session',
  :secret      => 'a9311be19dbf0305cc6007b98bd5c6fe41f5de1d31a13dbe946731b66c3661df6c176fd4ac28f1d0e7aaeeb21db6562a7fb4d8af0034380a1712a6635018f768'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
