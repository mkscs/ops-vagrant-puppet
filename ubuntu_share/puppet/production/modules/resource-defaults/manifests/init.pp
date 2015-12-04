class resource-defaults {
  Package {
    ensure      => present,
  }

  Service {
    hasrestart  => true,
    enable      => true,
    ensure      => true,
  }

  notify {'resource-defaults reached': }
  
  include resource-defaults::packages
  include resource-defaults::services
}