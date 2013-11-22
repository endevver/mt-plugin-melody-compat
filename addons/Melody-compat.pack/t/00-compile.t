#!/usr/local/bin/perl -w

use strict;
use warnings;

BEGIN {  
    $ENV{MT_CONFIG} ||= 'sqlite-test.cfg';
    use lib ( qw( lib extlib ),     "$ENV{MT_HOME}/t/lib", 
              "$ENV{MT_HOME}/lib",  "$ENV{MT_HOME}/extlib",
              "$ENV{MT_HOME}/addons/Log4MT.plugin/lib",
              "$ENV{MT_HOME}/addons/Log4MT.plugin/extlib"  );
    use Test::More tests => 1;
    use MT::Test;
}


BEGIN { use_ok( 'Melody::Compat' ); }