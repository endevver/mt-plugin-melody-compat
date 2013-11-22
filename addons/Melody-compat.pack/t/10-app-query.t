#!/usr/local/bin/perl -w
use strict;
use warnings;
BEGIN {  
    $ENV{MT_CONFIG} ||= 'sqlite-test.cfg';
    use lib ( qw( lib extlib ),     "$ENV{MT_HOME}/t/lib", 
              "$ENV{MT_HOME}/lib",  "$ENV{MT_HOME}/extlib",
              "$ENV{MT_HOME}/addons/Log4MT.plugin/lib",
              "$ENV{MT_HOME}/addons/Log4MT.plugin/extlib"  );
}

use Test::More tests => 3;
use MT::App::CMS;
use MT::Test qw( :app );

MT::Test->init_db();
MT::Test->init_cms();

my $app = MT->instance();
$app->init_plugins();
isa_ok( $app, 'MT::App', 'App is an MT::App subclass' );

isa_ok( $app->component('melody-compat'), 'MT::Component',
        'melody-compat loaded' );

diag('Testing whether MT::App can query()');
can_ok( 'MT::App', 'query' );

diag('Testing whether $app can query()');
can_ok( $app, 'query' );
