package Melody::Compat;

use base qw( Class::Data::Inheritable );

Melody::Compat->mk_classdata( is_disabled => 0 );

sub init_app {
    my ( $cb, $app ) = @_;
    return if __PACKAGE__->is_disabled();

    # Operate only on MT::App subclasses that can't query()
    return unless eval { $app->isa('MT::App') }
               && ! defined($app->can('query'));

    # Install definition for MT::App::query() as it is in Melody
    *{ref($app)."::query"} = sub {
        my $self    = shift;
        my ($query) = @_;
        return defined $query ? $self->{query} = $query
                              : $self->{query};
    };
    die "Could not install query method into ".(ref $app)
        unless $app->can('query');
}

# This callback is invoked when MT is initialized and ready to run.
# More specifically, after MT has initialized its addons, plugins,
# schema and permissions.  The arguments used to initialize MT are
# passed through to the callback.
sub post_init {
    my ($cb, $param) = @_;

    # PluginSwitch doesn't work with components
    __PACKAGE__->is_disabled( MT->product_code() eq 'OM' );
    return if __PACKAGE__->is_disabled();

    require Scalar::Util;

    my %seen;
    foreach my $c ( MT::Component->select(), MT::Plugin->select() ) {
        next if $c->id eq 'core' || $seen{Scalar::Util::refaddr($c)}++;
        my $plugin_class = eval { $c->registry('plugin_class') }
                        || eval { $c->{registry}{plugin_class} };
        if ( $plugin_class ) {
            eval "require $plugin_class;";
            die $@ if $@;
            bless $c, $plugin_class;
        }
    }
}

1;