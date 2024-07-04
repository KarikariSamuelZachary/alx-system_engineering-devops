# Ensure Nginx package is installed
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx listens on port 80
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Create the index.html with Hello World!
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Create the custom 404.html page
file { '/var/www/html/404.html':
  ensure  => file,
  content => 'Ceci n\'est pas une page',
}

# Configure Nginx for the redirection
nginx::resource::vhost { 'default':
  ensure       => present,
  www_root     => '/var/www/html',
  listen_port  => '80',
  error_log    => '/var/log/nginx/error.log',
  access_log   => '/var/log/nginx/access.log',
  index_files  => ['index.html', 'index.htm', 'index.nginx-debian.html'],
  error_pages  => {
    '404' => '/404.html',
  },
  locations    => {
    '/' => {
      'location_custom' => {
        'returns' => '301 https://www.example.com/',
      },
    },
    '/redirect_me' => {
      'location_custom' => {
        'returns' => '301 https://www.example.com/',
      },
    },
  },
}

