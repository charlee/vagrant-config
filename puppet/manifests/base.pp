class tools {
  package { [ "git", "tmux", "curl", "sqlite3", "zip", "unzip", "mercurial", "ack", "memcached", "redis-server" ]:
    ensure => present,
  }
}


class mysql {
  exec { "update-package-list":
    command => "/usr/bin/apt-get update",
  }

  package { 
    "mysql-server":
      ensure  => present,
      require => Exec["update-package-list"];

    "mysql-client":
      ensure  => present,
      require => Exec["update-package-list"];
  }

  service {
    "mysql":
      ensure  => running,
      require => Package["mysql-server"],
  }
  
}

class support {
  package {
    [ "libsqlite3-dev", "libxml2-dev", "libxslt1-dev", "libpq5", "libpq-dev", "nodejs" ]:
      ensure  => present,
  }
}

class python {
  package {
    "python":
      ensure  => present;

    "python-pip":
      ensure  => present;

    "python-dev":
      ensure  => present;

    "python-mysqldb":
      ensure  => present;

    [ "ipython", "django", "Mako", "Pillow", "numpy", "Flask", "jinja2", "coffin", "lxml", "dj-database-url", "python-memcached", "redis", "Flask-Scss", "pyScss", "flask-csrf", "Flask-Bcrypt" ]:
      ensure   => present,
      provider => 'pip',
      require  => Package["python-pip"];

    "py-bcrypt":
      ensure   => present,
      provider => 'pip',
      require  => [ Package["python-pip"], Package["python-dev"] ];
  }
}

class ruby {
  package {
    "rails":
      ensure  => present,
      provider => 'gem';
  }
}

class home {
  file {
    ".tmux.conf":
      mode => 0664,
      path => '/home/vagrant/.tmux.conf',
      source => '/vagrant/home/.tmux.conf';

    ".vimrc":
      mode => 0664,
      path => '/home/vagrant/.vimrc',
      source => '/vagrant/home/.vimrc';

    ".vim":
      mode => 0755,
      path => '/home/vagrant/.vim',
      source => '/vagrant/home/.vim';

    ".gitconfig":
      mode => 0664,
      path => '/home/vagrant/.gitconfig',
      source => '/vagrant/home/.gitconfig';
  }
}

include tools
include mysql
include support
include python
include ruby
include home
