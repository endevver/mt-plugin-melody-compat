package Melody::Compat;

use base qw(Class::Data::Inheritable);
Melody::Compat->mk_classdata( is_disabled => 0 );

sub init_app {
    my ( $cb, $app ) = @_;
    return if is_disabled();

    # Operate only on MT::App subclassed apps that can't query()
    return unless $app and $app->isa('MT::App');
    return if $app->can('query');

    # Install definition for MT::App::query() as it is in Melody
    *MT::App::query = sub {
        my $self    = shift;
        my ($query) = @_;
        return defined $query ? $self->{query} = $query
                              : $self->{query};
    }
}

# This callback is invoked when MT is initialized and ready to run.
# This callback is invoked after MT initialized addons, plugins, schema
# and permissions.  The arguments passed to initialize MT is passed
# through to the callback.
sub post_init {
    my ($cb, $param) = @_;

    # PluginSwitch doesn't work with components
    __PACKAGE__->is_disabled( MT->product_code() eq 'OM' );
    return if __PACKAGE__->is_disabled();

    foreach my $c ( MT::Component->select(), MT::Plugin->select() ) {
        my $plugin_class = eval { $c->registry('plugin_class') }
                        || eval { $c->{registry}{plugin_class} };
        if ($plugin_class) {
            eval "require $plugin_class;";
            die $@ if $@;
            bless $c, $plugin_class;
        }
    }
}

1;