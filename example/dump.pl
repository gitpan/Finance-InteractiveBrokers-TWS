package Local::Callback;

sub new {
    my $class = shift;
    return bless {}, $class;
}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 1;

my $callback = Local::Callback->new();

my $tws = Finance::InteractiveBrokers::TWS->new($callback);

$tws->read_data;

__END__

#   Create a contract
#
my $contract = $tws->Contract->new();
$contract->{m_symbol} = 'DELL';
$contract->{m_secType} = 'STK';
$contract->{m_exchange} = 'SMART';


my $order = $tws->Order->new();
$order->{m_action} = 'SELL';
$order->{m_orderType} = 'LMT';
$order->{m_tif} = 'DAY';
$order->{m_totalQuantity} = 1000;
$order->{m_lmtPrice} = 30.75;

$tws->dump(['contract','order'], [$contract, $order]),"\n";
#$tws->placeOrder($order_id, $contract, $order);

$tws->reqOpenOrders();

while (1) {
$tws->process_messages(3);

}
$tws->eDisconnect();

__END__

