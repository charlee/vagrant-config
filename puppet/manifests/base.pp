class tools {
  package { [ "git" ]:
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


include tools
include mysql
