package Local::Opt_Chain;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub contractDetails {

    my ($self, $summary) = @_;
    my $contract = $summary->{m_summary};

    push @{$self->{options}}, $contract;
}

sub AUTOLOAD {
    my ($self, @args) = @_;
    our $AUTOLOAD;
    return;
}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 1;

my $cb = Local::Opt_Chain->new( options => [] );

my $tws = Finance::InteractiveBrokers::TWS->new($cb);
$tws->eConnect("pt");

my $contract = $tws->Contract->new();
$contract->{m_symbol} = 'IBM';
$contract->{m_secType} = 'OPT';
$contract->{m_exchange} = 'SMART';

diag("requesting option chain takes a few seconds - please wait");
$tws->reqContractDetails($contract);
$tws->process_messages(3);

ok( $#{$cb->{options}} >= 0, "Successfully retrieved option chain");

$tws->eDisconnect();


