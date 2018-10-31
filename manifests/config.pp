# @summary Dump all parsed config settings
#
# @example Perform a dump to the output stream
#   puppet_dump::config { "point1": }
#
# @example Dump settings to file
#   puppet_dump::config { "point2":
#     save_to => "/tmp/config.txt",
#   }
#
# @param title
#   Unique reference for this dump
# @param save_to
#   If supplied, save debug output to this file
# @param save_mode
#   Permissions for dump file
define puppet_dump::config(
    Optional[String]  $save_to    = undef,
    String            $save_mode  = "0640",
) {
  $vars = inline_template("<%= a=%x{puppet config print} ; a  %>")

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
      notify { "puppet_dump::config ${title}:${i}":
        message => $e,
      }
    }
  }

}
