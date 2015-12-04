class profiles::base {
  notify { 'This is a base profile.': }
  contain resource-defaults
}
