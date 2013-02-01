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
include python
include ruby
