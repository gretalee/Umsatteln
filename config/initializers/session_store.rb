# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_project_session',
  :secret      => '4095df726d4b516b8e26a54ea9658ec87af4e3cba9794d7cddd477feba56d7ca653f36117e678d09694fd73aaf3597a909d0d96af82b8accd8cb5a6a721ff80a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
