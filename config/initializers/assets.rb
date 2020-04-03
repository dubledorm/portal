# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( libra/js/comment-reply.min.js libra/js/underscore.min.js
libra/sliders/polaroid/js/jquery.polaroid.js libra/sliders/polaroid/js/jquery.transform-0.8.0.min.js
libra/sliders/polaroid/js/jquery.preloader.js libra/js/jquery.colorbox-min.js
libra/js/jquery.masonry.js libra/js/jquery.easing.js libra/js/hoverIntent.min.js libra/js/media-upload.min.js
libra/js/jquery.clickout.min.js libra/js/responsive.js libra/js/mobilemenu.js libra/js/jquery.superfish.js
libra/js/jquery.placeholder.js libra/js/contact.js libra/js/jquery.tipsy.js libra/js/jquery.cycle.min.js
libra/js/shortcodes.js libra/js/jquery.custom.js libra/js/jquery/jquery.js )
