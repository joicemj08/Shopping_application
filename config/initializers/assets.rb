# Be sure to restart your server when you modify this file.
Rails.application.config.assets.precompile += %w( rails.validations.js )
# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( cart.js products.js autocomplete-rails.js categories.js offer.js users.js )
Rails.application.config.assets.precompile += %w( style_home.css )
Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( home.css )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
