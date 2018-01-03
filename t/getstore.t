use v6;
use Test;

use LWP::Simple;

plan 5;

if %*ENV<NO_NETWORK_TESTING> {
    diag "NO_NETWORK_TESTING was set";
    skip-rest("NO_NETWORK_TESTING was set");
    exit;
}

my $fname = $*SPEC.catdir($*TMPDIR, "./tmp-getstore-$*PID");
try unlink $fname;

ok(
    LWP::Simple.getstore('http://www.opera.com', $fname),
    'getstore() returned success'
);

my $fh = open($fname);
ok($fh, 'Opened file handle written by getstore()');

ok $fh.slurp-rest ~~ /Opera \s+ browser/, 'Found pattern in downloaded file';

ok($fh.close, 'Close the temporary file');

ok(unlink($fname), 'Delete the temporary file');
