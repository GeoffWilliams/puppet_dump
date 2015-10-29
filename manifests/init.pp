define puppet_dump() {
  $vars = inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>")

  notify { $title:
    message => $vars,
  }
}
