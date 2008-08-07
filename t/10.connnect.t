package Local::Callback;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub AUTOLOAD {                        # Catch-all to avoid errors
    my ($self, @args) = @_;
    our $AUTOLOAD;
    return;
}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 2;

my $cb = Local::Callback->new();

my $tws = Finance::InteractiveBrokers::TWS->new($cb);

ok($tws->eclient->eConnect()    eq 1, "Connected");
ok($tws->eclient->eDisconnect() eq 1, "Disconnected");


