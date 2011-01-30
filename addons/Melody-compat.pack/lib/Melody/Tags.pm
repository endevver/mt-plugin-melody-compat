package Melody::Tags;
use strict;

###########################################################################

=head2 JQueryURL

Returns the URL for the installation's jQuery library set by the
C<JQueryURL> configuration directive (in config.cgi) which defaults
to C<STATIC_WEB_PATH/jquery/jquery.js> if unset.

It can be set to any relative, absolute or external FQDN (fully-qualified
domain name) jQuery source URL which is useful in enhancing page
load performance.

B<CAVEAT:> This tag is used internally by Melody to load jQuery for its
admin UI screens so use caution if setting the directive to different
version than that which the application uses.  If you really must use a
different version of jQuery for your site's pages, you're better off
hardcoding it in your templates.

B<Example template tag usage:>

    <script src="<$mt:jqueryurl$>"
            type="text/javascript" charset="utf-8"></script>

B<Examples of config.cgi directive use (remember: CASE SENSITIVE!):>

    # Use a CDN for better caching and geographical distribution
    JQueryURL  http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js

    # Use a subdomain to parallelize loading of static helper files
    JQueryURL  http://static.mydomain.com/jquery/jquery.min.js

    # Non-FQDN, absolute URLs to internal resources work fine and are
    # preferred when you're publishing to multiple domains. In this case,
    # the tag will return the exact, non-FQDN value shown below.
    JQueryURL  /scripts/jquery/jquery.min.js

    # Relative URLs to internal resources are OK and will have
    # StaticWebPath prepended to it,
    # e.g. http://example.com/mt/mt-static/jquery/jquery.min.js
    JQueryURL  jquery/jquery.min.js

=for tags configuration

=cut

sub _hdlr_jquery_url { MT->instance->config->JQueryURL }

1;
