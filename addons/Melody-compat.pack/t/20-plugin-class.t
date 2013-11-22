#!/usr/local/bin/perl -w
use strict;
use warnings;
BEGIN {  
    $ENV{MT_CONFIG} = $ENV{MT_HOME}.'/addons/Melody-compat.pack/t/20-plugin-class.cfg';
    use lib ( qw( lib extlib ),     "$ENV{MT_HOME}/t/lib", 
              "$ENV{MT_HOME}/lib",  "$ENV{MT_HOME}/extlib",
              "$ENV{MT_HOME}/addons/Log4MT.plugin/lib",
              "$ENV{MT_HOME}/addons/Log4MT.plugin/extlib"  );
}

use Test::More tests => 2;
use MT::App::CMS;
use MT::Test qw( :app );
use Data::Dumper;
MT::Test->init_db();
MT::Test->init_cms();

my $app = MT->instance();
$app->init_plugins();

my $plugin   = $app->component('pclasstester');
isnt( $plugin, undef, 'Retrieval of pclasstester plugin');

SKIP: {
    skip "Couldn't retrieve PClassTester plugin", 2 unless $plugin;

    is( $plugin->registry('plugin_class'), 'PClassTester',
        'PClassTester plugin_class registry key' );

    is( ref $plugin, 'PClassTester' );
}


1;

