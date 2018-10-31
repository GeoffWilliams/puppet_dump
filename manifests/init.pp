# @summary Print out all the variables in scope using notify
#
# @example Performing a dump
#   puppet_dump { "point1": }
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
  $vars = inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>")

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
