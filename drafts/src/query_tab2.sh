#!/usr/bin/tclsh
if {$argc!=2} {
  puts stderr "Usage: %s DATABASE SQL-STATEMENT"
  exit 1
}
load /usr/lib/sqlite3/libtclsqlite3.dylib Sqlite3
sqlite3 db [lindex $argv 0]
db eval [lindex $argv 1] x {
  foreach v $x(*) {
    puts "$v = $x($v)"
  }
  puts ""
}
db close
