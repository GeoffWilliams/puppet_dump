# @PDQTest
puppet_dump::settings { "point1": }
puppet_dump::settings { "point2":
  save_to => "/tmp/settings.txt",
}
