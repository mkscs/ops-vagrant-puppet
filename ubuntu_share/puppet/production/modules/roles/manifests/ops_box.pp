class roles::ops_box {
  include profiles::base
  include profiles::devtools
  Class['profiles::base'] -> Class['profiles::devtools']
}
