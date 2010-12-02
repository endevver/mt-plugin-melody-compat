use ExtUtils::MakeMaker;

use strict;
use warnings;
use version 0.77;
use YAML::Any qw(LoadFile);

# Defaults to: glob('{plugins,addons}/*/config.yaml');
my $yaml = parse_config_yaml(); 

%MKARGS = (
    NAME      => plugin_name(),
    VERSION   => plugin_version(),
    DISTNAME  => plugin_id(),
    ABSTRACT  => plugin_description(),
    AUTHOR    => plugin_author(),
    DISTVNAME => plugin_distvname(),
);

@valid_args = grep { defined $MKARGS{$_} and $MKARGS{$_} ne '' } keys %MKARGS;

WriteMakefile( map { $_ => $MKARGS{$_} } @valid_args );

sub parse_config_yaml {
    my ($config) = @_ || glob( '{plugins,addons}/*/config.yaml' );
    my $yaml    = eval { LoadFile( $config ) };
    $yaml or die "Could not parse config.yaml: ".($YAML::Tiny::errstr || $@);
    return $yaml;
}

sub plugin_name {
    warn "No name found in config.yaml" unless $yaml->{name};
    return $yaml->{name};
}

sub plugin_id {
    my $id = $yaml->{id} || $yaml->{key};
    warn 'No ID or key found in config.yaml' unless $id;
    return $id;
}

sub plugin_author {
    my @fields = grep { defined $yaml->{$_} } qw(author_name author_link) )
        or warn "No author information found in config.yaml";
    return @fields ? join( ' ,',  map { $yaml->{$_} } @fields ) : '';
}

sub plugin_description {
    warn "No description found in config.yaml" unless $yaml->{description};
    return $yaml->{description};
}

sub plugin_version {
    my $v = shift || $yaml->{version};
    unless ( $v ) {
        warn "No version found in config.yaml";
        return;
    }
    $v =~ s{^v?}{v};                         # Prepend v if needed for vstring
    $vobj = eval { version->declare( $v ) }; # Attempt to objectify version
    return ( $vobj || $v );                  # Return vobj if succeeded
}

sub plugin_distvname {
    join( '-', 'mt-plugin-'.lc( plugin_id() ), plugin_version() )
}


# LICENSE
#  The licensing terms of your distribution.  Generally its "perl" for
#  the same license as Perl itself.
# 
#  See Module::Build::API for the list of options.
# 
#  Defaults to "unknown".
#          
# MIN_PERL_VERSION
#  The minimum required version of Perl for this distribution.
#  Either 5.006001 or 5.6.1 format is acceptable.
# 
# NAME
#  Perl module name for this extension (DBD::Oracle). This will default
#  to the directory name but should be explicitly defined in the
#  Makefile.PL.
# 
# PREREQ_PM
#  A hash of modules that are needed to run your module.  The keys are
#  the module names ie. Test::More, and the minimum version is the
#  value. If the required version number is 0 any version will do.
# 
#  This will go into the "requires" field of your META.yml.
# 
#      PREREQ_PM => {
#          # Require Test::More at least 0.47
#          "Test::More" => "0.47",
# 
#          # Require any version of Acme::Buffy
#          "Acme::Buffy" => 0,
#      }
# 
# PREREQ_PRINT
#  Bool.  If this parameter is true, the prerequisites will be printed
#  to stdout and MakeMaker will exit.  The output format is an evalable
#  hash ref.
# 
#    $PREREQ_PM = {
#                   'A::B' => Vers1,
#                   'C::D' => Vers2,
#                   ...
#                 };
# 
#  If a distribution defines a minimal required perl version, this is
#  added to the output as an additional line of the form:
# 
#    $MIN_PERL_VERSION = '5.008001';
# 
#  If BUILD_REQUIRES is not empty, it will be dumped as $BUILD_REQUIRES
#  hasref.
# 
# PRINT_PREREQ
#  RedHatism for "PREREQ_PRINT".  The output format is different,
#  though:
# 
#      perl(A::B)>=Vers1 perl(C::D)>=Vers2 ...
# 
#  A minimal required perl version, if present, will look like this:
# 
#      perl(perl)>=5.008001

