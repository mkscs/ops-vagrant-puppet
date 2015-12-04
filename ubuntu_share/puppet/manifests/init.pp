node default {

  host { 'vagrantlayer':
    ensure        => 'present',
    host_aliases  => ['vagrantlayer'], 
    ip            => '10.0.1.10',
    target        => '/etc/hosts',
    require       => Exec["immutable_resolv_conf"],
  }


  package {'puppetmaster':
    ensure        => latest,
    require       => Host['vagrantlayer'],
  }
  
  package {'librarian-puppet':
    provider      => gem,
    ensure        => latest,
  }
  
  file {'/etc/puppet/Puppetfile':
    ensure        => present,
    source        => "/home/vagrant/projects/files/Puppetfile",
  }
  
  exec {'librarian_puppet_modules':
    command       => '/usr/local/bin/librarian-puppet install',
    cwd           => '/etc/puppet/',
    require       => File['/etc/puppet/Puppetfile'],
  }
  
  package {'hiera':
    ensure        => latest,
  }
  
  file {'/etc/puppet/hiera.yaml':
    ensure        => present,
    source        => "/home/vagrant/projects/files/hiera.yaml",
  }  
  
  file {'/etc/hiera.yaml':
    ensure        => link,
    target        => "/etc/puppet/hiera.yaml",
  }
  file {'/etc/puppet/puppet.conf':
    ensure        => present,
    owner         => root,
    group         => root,
    source        => "/home/vagrant/projects/files/puppet.conf",
    require       => Package['puppetmaster'],
  }  

  file { "/etc/puppet/environments":
    ensure        => "directory",
    owner         => "root",
    group         => "root",
    mode          => '0774',
  }
  
  file { "/etc/puppet/environments/production":
    ensure        => link,
    target        => "/home/vagrant/projects/puppet/production"
  }

  file {'/etc/resolv.conf':
    ensure        => file,
    content       => "nameserver localhost\nnameserver 8.8.8.8\n",
  }

  exec { 'immutable_resolv_conf':
    command       => "/usr/bin/chattr +i /etc/resolv.conf",
    onlyif        => "/usr/bin/test -w /etc/resolv.conf",
    require       => File['/etc/resolv.conf'],
  }
}
