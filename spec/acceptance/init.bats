@test "puppet_dump OK" {
  ls /tmp/puppet_dump.txt
}

@test "finds our variable OK" {
  grep "foobar: abc"  /tmp/puppet_dump.txt
}
