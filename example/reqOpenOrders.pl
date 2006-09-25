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
#my $contract = $tws->Contract->new();
#$contract->{m_symbol} = 'DELL';
#$contract->{m_secType} = 'STK';
#$contract->{m_exchange} = 'SMART';

#   Create an order
#

#my $order = $tws->Order->new();
#$order->{m_action} = 'SELL';
#$order->{m_orderType} = 'LMT';
#$order->{m_orderType} = 'MKT';
#$order->{m_tif} = 'DAY';
#$order->{m_totalQuantity} = 1000;
#$order->{m_lmtPrice} = 30.75;

#$tws->placeOrder($order_id, $contract, $order);

$tws->reqOpenOrders();

while (1) {
    $tws->process_messages(3);
}

$tws->eDisconnect();

__END__

Seems to be a one time shot, in that I only get back the currently open orders, and do not get back orders opened after issuing this method


1..1
Server Version:26
TWS Time at connection:20060423 10:14:00 CST
2 second wait - while TWS connection process completes

****Called nextValidId: 
$VAR1 = {
          'orderId' => '25717'
        };

****Called openOrder: 
$VAR1 = {
          'orderId' => '25716',
          'contract' => {
                          'm_symbol' => 'CSC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_right' => '?',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'CSC',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'order' => {
                       'm_orderId' => '25716',
                       'm_clientId' => '0',
                       'm_permId' => '1855220089',
                       'm_action' => 'SELL',
                       'm_totalQuantity' => '100',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '59.0',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '1855220089.1/U77/100',
                       'm_tif' => 'DAY',
                       'm_account' => 'U77',
                       'm_openClose' => 'O',
                       'm_origin' => '0',
                       'm_transmit' => '1',
                       'm_parentId' => '0',
                       'm_blockOrder' => '0',
                       'm_sweepToFill' => '0',
                       'm_displaySize' => '0',
                       'm_triggerMethod' => '0',
                       'm_ignoreRth' => '0',
                       'm_hidden' => '0',
                       'm_discretionaryAmt' => '0.0',
                       'm_primaryExch' => '',
                       'm_shortSaleSlot' => '0',
                       'm_ocaType' => '3',
                       'm_rthOnly' => '0',
                       'm_overridePercentageConstraints' => '0',
                       'm_allOrNone' => '0',
                       'm_minQty' => '0',
                       'm_percentOffset' => '0.0',
                       'm_eTradeOnly' => '0',
                       'm_firmQuoteOnly' => '0',
                       'm_nbboPriceCap' => '0.0',
                       'm_auctionStrategy' => '1',
                       'm_startingPrice' => '0.0',
                       'm_stockRefPrice' => '0.0',
                       'm_delta' => '0.0',
                       'm_stockRangeLower' => '0.0',
                       'm_stockRangeUpper' => '0.0'
                     }
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '25716',
          'status' => 'Submitted',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220089',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called openOrder: 
$VAR1 = {
          'orderId' => '25715',
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_right' => '?',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'DELL',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'order' => {
                       'm_orderId' => '25715',
                       'm_clientId' => '0',
                       'm_permId' => '1855220088',
                       'm_action' => 'SELL',
                       'm_totalQuantity' => '100',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '27.0',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '1855220088.1/U77/100',
                       'm_tif' => 'DAY',
                       'm_account' => 'U77',
                       'm_openClose' => 'O',
                       'm_origin' => '0',
                       'm_transmit' => '1',
                       'm_parentId' => '0',
                       'm_blockOrder' => '0',
                       'm_sweepToFill' => '0',
                       'm_displaySize' => '0',
                       'm_triggerMethod' => '0',
                       'm_ignoreRth' => '0',
                       'm_hidden' => '0',
                       'm_discretionaryAmt' => '0.0',
                       'm_primaryExch' => '',
                       'm_shortSaleSlot' => '0',
                       'm_ocaType' => '3',
                       'm_rthOnly' => '0',
                       'm_overridePercentageConstraints' => '0',
                       'm_allOrNone' => '0',
                       'm_minQty' => '0',
                       'm_percentOffset' => '0.0',
                       'm_eTradeOnly' => '0',
                       'm_firmQuoteOnly' => '0',
                       'm_nbboPriceCap' => '0.0',
                       'm_auctionStrategy' => '1',
                       'm_startingPrice' => '0.0',
                       'm_stockRefPrice' => '0.0',
                       'm_delta' => '0.0',
                       'm_stockRangeLower' => '0.0',
                       'm_stockRangeUpper' => '0.0'
                     }
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '25715',
          'status' => 'Submitted',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220088',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };
ok 1 - Connected

****Called openOrder: 
$VAR1 = {
          'orderId' => '25716',
          'contract' => {
                          'm_symbol' => 'CSC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_right' => '?',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'CSC',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'order' => {
                       'm_orderId' => '25716',
                       'm_clientId' => '0',
                       'm_permId' => '1855220089',
                       'm_action' => 'SELL',
                       'm_totalQuantity' => '100',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '59.0',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '1855220089.1/U77/100',
                       'm_tif' => 'DAY',
                       'm_account' => 'U77',
                       'm_openClose' => 'O',
                       'm_origin' => '0',
                       'm_transmit' => '1',
                       'm_parentId' => '0',
                       'm_blockOrder' => '0',
                       'm_sweepToFill' => '0',
                       'm_displaySize' => '0',
                       'm_triggerMethod' => '0',
                       'm_ignoreRth' => '0',
                       'm_hidden' => '0',
                       'm_discretionaryAmt' => '0.0',
                       'm_primaryExch' => '',
                       'm_shortSaleSlot' => '0',
                       'm_ocaType' => '3',
                       'm_rthOnly' => '0',
                       'm_overridePercentageConstraints' => '0',
                       'm_allOrNone' => '0',
                       'm_minQty' => '0',
                       'm_percentOffset' => '0.0',
                       'm_eTradeOnly' => '0',
                       'm_firmQuoteOnly' => '0',
                       'm_nbboPriceCap' => '0.0',
                       'm_auctionStrategy' => '1',
                       'm_startingPrice' => '0.0',
                       'm_stockRefPrice' => '0.0',
                       'm_delta' => '0.0',
                       'm_stockRangeLower' => '0.0',
                       'm_stockRangeUpper' => '0.0'
                     }
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '25716',
          'status' => 'Submitted',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220089',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called openOrder: 
$VAR1 = {
          'orderId' => '25715',
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_right' => '?',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'DELL',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'order' => {
                       'm_orderId' => '25715',
                       'm_clientId' => '0',
                       'm_permId' => '1855220088',
                       'm_action' => 'SELL',
                       'm_totalQuantity' => '100',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '27.0',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '1855220088.1/U77/100',
                       'm_tif' => 'DAY',
                       'm_account' => 'U77',
                       'm_openClose' => 'O',
                       'm_origin' => '0',
                       'm_transmit' => '1',
                       'm_parentId' => '0',
                       'm_blockOrder' => '0',
                       'm_sweepToFill' => '0',
                       'm_displaySize' => '0',
                       'm_triggerMethod' => '0',
                       'm_ignoreRth' => '0',
                       'm_hidden' => '0',
                       'm_discretionaryAmt' => '0.0',
                       'm_primaryExch' => '',
                       'm_shortSaleSlot' => '0',
                       'm_ocaType' => '3',
                       'm_rthOnly' => '0',
                       'm_overridePercentageConstraints' => '0',
                       'm_allOrNone' => '0',
                       'm_minQty' => '0',
                       'm_percentOffset' => '0.0',
                       'm_eTradeOnly' => '0',
                       'm_firmQuoteOnly' => '0',
                       'm_nbboPriceCap' => '0.0',
                       'm_auctionStrategy' => '1',
                       'm_startingPrice' => '0.0',
                       'm_stockRefPrice' => '0.0',
                       'm_delta' => '0.0',
                       'm_stockRangeLower' => '0.0',
                       'm_stockRangeUpper' => '0.0'
                     }
        };

****Called orderStatus: 
$VAR1 = {
          'orderId' => '25715',
          'status' => 'Submitted',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220088',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };
