OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '567901973559-e51qtv6ueavalr7id331abp8ac0gp051.apps.googleusercontent.com', 'fP9hP2Xd2wtiyB351Uh1BobD', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
