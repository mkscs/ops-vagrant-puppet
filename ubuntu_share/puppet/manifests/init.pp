node default {

  host { 'vagrantlayer':
    ensure        => 'present',
    host_aliases  => ['vagrantlayer'], 
    ip            => '10.0.1.10',
    target        => '/etc/hosts',
    require => Exec["/usr/bin/chattr +i /etc/resolv.conf"],
  }


  package {'puppetmaster':
    ensure => latest,
    require => Host['vagrantlayer'],
  }

  file {'/etc/puppet/puppet.conf':
    ensure => present,
    owner => root,
    group => root,
    source => "/home/vagrant/projects/files/puppet.conf",
    require => Package['puppetmaster'],
  }  


  $puppet_agent_dirs = ["/etc/puppet/environments",
                        "/etc/puppet/environments/production",
                        "/etc/puppet/environments/production/manifests",
                        "/etc/puppet/environments/production/modules",
                       ]

  file { $puppet_agent_dirs:
    ensure => "directory",
    owner => "root",
    group => "root",
    mode => '0077',
  }

  file {'/etc/resolv.conf':
    ensure  => file,
    content => "nameserver localhost\nnameserver 8.8.8.8\n",
  }

  exec { "/usr/bin/chattr +i /etc/resolv.conf":
    require => File['/etc/resolv.conf'],
  }
}
