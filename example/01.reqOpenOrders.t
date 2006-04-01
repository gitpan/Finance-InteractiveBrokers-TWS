package Local::Callback;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub AUTOLOAD {
    my ($self, @args) = @_;
    our $AUTOLOAD;

    my $sub_name = $AUTOLOAD;
    $sub_name =~ s/^.*:://;

    print "\n****Called $sub_name: \n";

    $self->{tws}->dump_event($sub_name, \@args);

    return;

}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 1;

my $callback = Local::Callback->new();

my $tws = Finance::InteractiveBrokers::TWS->new($callback);

$callback->{tws} = $tws;

ok($tws->eConnect(pt, 7497, 0) >=1, 'Connected');

my $order_id = $$;

#   Create a contract
#
my $contract = $tws->Contract->new();
$contract->{m_symbol} = 'DELL';
$contract->{m_secType} = 'STK';
$contract->{m_exchange} = 'SMART';

#   Create an order
#

my $order = $tws->Order->new();
$order->{m_action} = 'SELL';
$order->{m_orderType} = 'LMT';
$order->{m_tif} = 'DAY';
$order->{m_totalQuantity} = 1000;
$order->{m_lmtPrice} = 30.75;

#$tws->placeOrder($order_id, $contract, $order);

$tws->reqOpenOrders();

while (1) {
$tws->process_messages(3);

}
$tws->eDisconnect();

__END__

