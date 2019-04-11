# @summary Print out all the variables in scope using notify
#
# @example Performing a dump
#   puppet_dump { "point1": }
#
# @example Dump settings to file
#   puppet_dump { "point2":
#     save_to => "/tmp/config.txt",
#   }
#
# @param title
#   A unique name to identify the position in code that
#   this dump was made at
# @param save_to
#   If supplied, save debug output to this file
# @param save_mode
#   Permissions for dump file
define puppet_dump(
    Optional[String]  $save_to    = undef,
    String            $save_mode  = "0640",
) {

  # get the facts + variables from our _parent_ scope (eg the caller...)
  # otherwise we would be dumping our _own_variables, eg `save_to`, `save_mode`
  $vars = inline_template("<%= vars = {}; scope.parent.to_hash.each_pair {|k,v| vars[k.to_s] = v.to_s}; vars.to_yaml %>")

  if $save_to {
    file { $save_to:
      ensure  => file,
      owner   => "root",
      group   => "root",
      mode    => $save_mode,
      content => $vars,
    }
  } else {
    $vars.split('\\n').each |$i,$e| {
      notify { "puppet_dump ${title}:${i}":
        message => $e,
      }
    }
  }
}
