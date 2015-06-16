class VHost #NginxVirtualHost

  DEFAULT_HOST = "mkvd.net"

  def self.template_string(server_name:, app_name:, path:, passenger: nil)
    <<-EOS.gsub(/^\s\s\s\s/, '')
    server {
      listen 80;
      server_name #{server_name};
      root /www/#{app_name}#{path};
      #{"passenger_enabled on;" if passenger}
    }
    EOS
  end

  def self.template(subdomain: nil, host: DEFAULT_HOST, app_name:, features:)
    server_name = "#{"#{subdomain}." if subdomain}#{host}"
    path        = ""
    path        = "/public"          if features.include?(:passenger)
    path        = "/current/public"  if features.include?(:mina)

    template_string(
      server_name:  server_name,
      app_name:     app_name,
      path:         path,
      passenger:    features.include?(:passenger)
    )
  end

  def self.default_template
    template(
      subdomain: "deploy", # you need to pass a subdomain for the mkvd.net and/or a host
      app_name:  "raudo",
      features:  %i(passenger mina),
    )
  end

  def self.all
    {
      default: {
        subdomain: "default",
      },
      biwi: {
        subdomain: "biwi",
      },
      wiki_sinatra: {
        subdomain: "wiki",
        domain:    "makevoid.com",
      },
      raudo: {
        subdomain: "deploy",
      },
      raudo: {
        subdomain: "deploy",
      },
      raudo: {
        subdomain: "deploy",
      },
      # antani: {
      #   domain: "antani.com",
      # },
      # sblinda: {
      #   subdomain: "sblinda",
      #   domain:    "antani.com"
      # }
    }
    # 000_default  001_biwi  002_wiki_sinatra  003_bitnfc  004_dogenfc  005_raudo
  end

end
