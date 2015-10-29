# puppet_dump
# ===========
# Print out all the variables in scope using notify
#
# Parameters
# ----------
# [*title*]
#   A unique name to identify the position in code that
#   this dump was made at
define puppet_dump() {
  $vars = inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>")

  notify { $title:
    message => $vars,
  }
}
