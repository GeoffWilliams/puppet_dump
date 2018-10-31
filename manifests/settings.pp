# @summary Dump the active puppet settings
#
# @example Perform a dump to the output stream
#   puppet_dump::settings { "point1": }
#
# @example Dump settings to file
#   puppet_dump::settings { "point2":
#     save_to => "/tmp/settings.txt",
#   }
#
# @param title
#   Unique reference for this dump
# @param save_to
#   If supplied, save debug output to this file
# @param save_mode
#   Permissions for dump file
define puppet_dump::settings(
    Optional[String] $save_to   = undef,
    String           $save_mode = "0640",
) {
  $vars = inline_template('<%= Puppet.settings.map { |k,v| "#{k}=>#{v.value}" }.to_yaml %>')

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
      notify { "puppet_dump::settings:${title}:${i}":
        message => $e,
      }
    }
  }

}

