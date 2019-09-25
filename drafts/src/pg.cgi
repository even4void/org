#!/usr/bin/perl

use DBI;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use strict;

my $c = new CGI();
my $dbname = 'test';
my $user = 'postgres';
my $pass = 'lolita';

print $c->header();
print $c->start_html("Reading names from table 'tab1' in db 'test'");

my $dbh = DBI->connect("dbi:Pg:dbname=$dbname", $user, $pass) or die DBI::errstr;

my $res = $dbh->selectall_arrayref("select name from tab1");

for my $row (@$res)
{
    print 'Name: ' , @$row[0] , '<br>';
}

$dbh->disconnect();

print $c->end_html();
