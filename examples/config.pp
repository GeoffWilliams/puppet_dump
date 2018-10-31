# @PDQTest
puppet_dump::config { "point1": }
puppet_dump::config { "point2":
  save_to => "/tmp/config.txt",
}
