Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '659296247736629', '0e5c1b146f44330f87f363de38fa0543'
end