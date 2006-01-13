package Callback;
use strict;

sub new {
    bless {}, shift;
}

sub tickPrice {
    my $self = shift;
    print "tickPrice called with: ", join(" ", @_), "\n";
}

sub tickSize {
    my $self = shift;
    print "tickSize called with: ", join(" ", @_), "\n";
}

sub nextValidId {
    my $self = shift;
    print "nextValidId called with: ", join(" ", @_), "\n";
}

sub error {
    my $self = shift;
    print "error: ", join(" ", @_), "\n";
}

package main;

use strict;
use Finance::InteractiveBrokers::TWS;

my $callback = Callback->new();
my $tws      = Finance::InteractiveBrokers::TWS->new(callback=>$callback);
my $ib       = $tws->get_EClientSocket();
my $api      = $tws->get_api();

####                        Host         Port    Client_ID
####                        ----         ----    ---------
my @tws_GUI_location = qw/  127.0.0.1    7496       15     /;

$ib->eConnect(@tws_GUI_location);
$api->OpenCallbackStream() ;

my $flag = 1;

my $contract = $tws->new_Contract();
$contract->{m_symbol} = 'YHOO';
$contract->{m_secType} = 'STK';
$contract->{m_exchange} = 'SMART';

while ((my $got_data = $api->WaitForCallback(.01)) > -1) {

    if ($got_data) {
        $api->ProcessNextCallback() ;
    }
    else {
        if ($flag) {
            $flag=0;
            my $contract_id = 50;
            $ib->reqMktData($contract_id, $contract);
        }
    }
}

