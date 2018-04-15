use v6;
use Test;

use LWP::Simple;

plan 1;

if %*ENV<NO_NETWORK_TESTING> {
    diag "NO_NETWORK_TESTING was set";
    skip-rest("NO_NETWORK_TESTING was set");
    exit;
}

# this page is, for now, delivered by a server that does not provide
# a content length or do chunking
my $html = LWP::Simple.get('http://rakudo.org');

ok(
    $html.match('Perl 6') &&
        $html.match('</html>') && $html.chars > 2_800,
    'make sure we pulled whole document without, we believe, sizing from server'
);
