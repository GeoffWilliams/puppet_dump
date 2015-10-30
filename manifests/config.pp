define puppet_dump::config() {
  $config = inline_template("<%= a=%x{puppet config print} ; a  %>")
  notify { $title:
    message => $config,
  }
}
