package Local::PlaceOrder;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub AUTOLOAD {
    my ($self, @args) = @_;
    our $AUTOLOAD;

    my $sub_name = $AUTOLOAD;
    $sub_name =~ s/^.*:://;

    if ($sub_name eq 'nextValidId') {
        $self->{order_id} = $args[0];
    }
    
    print "\n****Called $sub_name: \n";

    $self->{tws}->dump_event($sub_name, \@args);

    return;
}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 1;

my $callback = Local::PlaceOrder->new();

my $tws = Finance::InteractiveBrokers::TWS->new($callback);

$callback->{tws} = $tws;

ok($tws->eConnect(pt, 7497, 0) >=1, 'Connected');

my $contract = $tws->Contract->new();
$contract->{m_symbol} = 'F';
$contract->{m_secType} = 'STK';
$contract->{m_exchange} = 'SMART';

my $order = $tws->Order->new();
$order->{m_action} = 'BUY';
$order->{m_orderType} = 'MKT';
$order->{m_tif} = 'DAY';
$order->{m_totalQuantity} = 1000;
$order->{m_transmit} = 1;
$order->{m_rthOnly} = 0;

my $contract = $tws->Contract->new();
$contract->{m_symbol} = 'DELL';
$contract->{m_secType} = 'STK';
$contract->{m_exchange} = 'SMART';

print "PLACING FIRST ORDER\n";

my $order_id = get_next_order_id();
$tws->placeOrder($order_id, $contract, $order);

$order->{m_orderType} = 'LMT';
$order->{m_lmtPrice} = 7.95;

print "PLACING SECOND ORDER\n";
$contract->{m_symbol} = 'DELL';
$tws->placeOrder(get_next_order_id(), $contract, $order);

while (1) {
    $tws->process_messages(3);
}

$tws->eDisconnect();

sub get_next_order_id {

    $callback->{order_id} = 0;
    $tws->reqIds(1);

    while ($callback->{order_id} == 0) {
        $tws->process_messages(.1);
    }

    return $callback->{order_id};
}
    
__END__

1..1
Server Version:25
TWS Time at connection:20060327 22:09:36 CST
2 second wait - while TWS connection process completes

****Called nextValidId: 
$VAR1 = {
          'orderId' => '4516'
        };
ok 1 - Connected
PLACING FIRST ORDER

****Called nextValidId: 
$VAR1 = {
          'orderId' => '4516'
        };
PLACING SECOND ORDER

****Called nextValidId: 
$VAR1 = {
          'orderId' => '4517'
        };

****Called execDetails: 
$VAR1 = {
          'orderId' => '4516',
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'DELL',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '4516',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.884f02de.01.01',
                           'm_time' => '20060327  22:09:39',
                           'm_acctNumber' => 'U5',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '1000',
                           'm_price' => '30.09',
                           'm_permId' => '782807531',
                           'm_liquidation' => '0'
                         }
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '4516',
          'status' => 'Filled',
          'filled' => '1000',
          'remaining' => '0',
          'avgFillPrice' => '30.09',
          'permId' => '782807531',
          'parentId' => '0',
          'lastFillPrice' => '30.09',
          'clientId' => '0'
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '4516',
          'status' => 'Filled',
          'filled' => '1000',
          'remaining' => '0',
          'avgFillPrice' => '30.09',
          'permId' => '782807531',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '4517',
          'status' => 'Submitted',
          'filled' => '0',
          'remaining' => '1000',
          'avgFillPrice' => '0.0',
          'permId' => '782807532',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called error: 
$VAR1 = {
          'id' => '4517',
          'errorCode' => '202',
          'errorMsg' => 'Order Canceled - reason:'
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '4517',
          'status' => 'Cancelled',
          'filled' => '0',
          'remaining' => '1000',
          'avgFillPrice' => '0.0',
          'permId' => '782807532',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };
