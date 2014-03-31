#!/usr/bin/perl -w
# 2013 by Bernhard M. Wiedemann
use strict;
my $host=shift||"10.122.186.165";
my $pw= $ENV{PW} || "cr0wBar!";
#$pw="crowbar";

use LWP::UserAgent;
my $mech = LWP::UserAgent->new();
$mech->cookie_jar({});
my $c=$mech->post("http://$host/rpc/WEBSES/create.asp", Content=>"WEBVAR_USERNAME=root&WEBVAR_PASSWORD=$pw");
$c=$c->content();
$c=~/'SESSION_COOKIE' : '([^']+)'/ or die "no cookie";
my $cookie=$1;
$mech->cookie_jar->set_cookie(1, "SessionCookie", $cookie, "/", $host);
$c=$mech->get("http://$host/Java/jviewer.jnlp?ext_ip=$host")->content;
$c=~s/https/http/;
print $c;
