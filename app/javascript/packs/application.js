// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// require("jquery")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
 const images = require.context('../images', true)
 const imagePath = (name) => images(name, true)

import('../styles/libra/css/reset');
import('../styles/libra/css/bootstrap');
import('../styles/libra/style');

import('../styles/libra/js/thickbox/thickbox');
import('../styles/libra/sliders/usquare/css/frontend/usquare_style');
import('../styles/libra/sliders/usquare/css/frontend/jquery.mCustomScrollbar');

import('../styles/libra/sliders/usquare/fonts/ostrich sans/stylesheet');
import('../styles/libra/sliders/usquare/fonts/PT sans/stylesheet');

import('../styles/libra/css/responsive');
import('../styles/libra/sliders/polaroid/css/polaroid');
import('../styles/libra/css/shortcodes');
import('../styles/libra/css/featurestab');
import('../styles/libra/css/contact_form');
import('../styles/libra/css/custom');

// import $ from 'jquery';


var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
