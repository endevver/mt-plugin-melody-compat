package Melody::ConfigDirectives;
use strict;

sub _jquery_handler {
    my $mgr = shift;
    return $mgr->set_internal( 'JQueryURL', @_ ) if @_;
    require MT::Util;
    my $url = $mgr->get_internal('JQueryURL');
    if ( !$url ) {
        $url = MT::Util::caturl( MT->instance->static_path(),
                                 'jquery', 'jquery.js' );
    }
    elsif ( $url !~ m{^http://}i and substr( $url, 0, 1 ) ne '/' ) {
        $url = MT::Util::caturl( MT->instance->static_path(), $url );
    }
    return $url;
}

1;

