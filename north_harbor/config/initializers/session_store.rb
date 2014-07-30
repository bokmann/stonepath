# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stonepath_sample_session',
  :secret      => 'ab6b07825c603f88453e1a55ec9b4936b1cdfbc02a417a1dbee7c8e6703ccb5319f07d945823d99a13d86025e360c83c41baf8d382fd8cde67bf8df56d83262c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
