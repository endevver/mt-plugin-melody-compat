#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {  
    $ENV{MT_CONFIG} ||= 'sqlite-test.cfg';
    use lib qw( $MT_HOME/t/lib t/lib );
}

use Test::More tests => 7;
use MT::Test;

MT::Test->init_db();
MT::Test->init_data();

my $mt       = MT->instance;
my $plugin   = $mt->component('melody-compat');
my $registry = $plugin->registry() || {};
my %config   = (
    name        => 'Melody Compatibility Layer for Movable Type',
    description => 'An addon for MT 4.x that aims to provide seamless compatiblity with all Melody plugins',
    id          => 'MelodyCompat',
    key         => 'MelodyCompat',
    author_link => 'http://endevver.com/',
    author_name => 'Endevver',
    version     => '1.0.0',
);

foreach my $k ( keys %config ) {
    is( $registry->{$k}, $config{$k}, "Config test - $k" );
}
