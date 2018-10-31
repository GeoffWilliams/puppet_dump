# @PDQTest
puppet_dump { "point1": }

$foobar = "abc"

puppet_dump { "point2":
  save_to => "/tmp/puppet_dump.txt",
}
