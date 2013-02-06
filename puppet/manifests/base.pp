class tools {
  package { [ "git", "tmux", "curl", "sqlite3" ]:
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

    "ipython":
      ensure   => present,
      provider => 'pip',
      require  => Package["python-pip"];
  }
}

class ruby {
  package {
    "rails":
      ensure  => present,
      provider => 'gem';
  }
}

include tools
include mysql
include support
include python
include ruby
