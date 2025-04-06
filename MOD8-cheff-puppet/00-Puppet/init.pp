# lamp_stack/manifests/init.pp
class lamp_stack {
  package { ['apache2', 'mysql-server', 'php', 'libapache2-mod-php']:
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
    enable => true,
    require => Package['apache2'],
  }

  service { 'mysql':
    ensure => running,
    enable => true,
    require => Package['mysql-server'],
  }
}
