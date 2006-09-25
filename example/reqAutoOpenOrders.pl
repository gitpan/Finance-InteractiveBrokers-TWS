package Local::reqAccountUpdates;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub AUTOLOAD {
    my ($self, @args) = @_;
    our $AUTOLOAD;

    my $sub_name = $AUTOLOAD;
    $sub_name =~ s/^.*:://;

    print "\n****Called $sub_name \n";

    $self->{tws}->dump_event($sub_name, \@args);

    return;
}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 1;

my $callback = Local::reqAccountUpdates->new();

my $tws = Finance::InteractiveBrokers::TWS->new($callback);

$callback->{tws} = $tws;

ok($tws->eConnect(pt, 7497,0) >=1, 'Connected');

$tws->reqAutoOpenOrders("1");

while (1) {
    $tws->process_messages(3);
}

$tws->eDisconnect();

__END__

This is a continuous method, in that once issued (and bAutoBind TRUE), your API code will receive openOrder, orderStatus, and execDetails events. All openOrders will be listed, and as orders change status (submitted, filled, cancelled...), as well as execDetails from that point on will get reported.

1..1
Server Version:26
TWS Time at connection:20060423 08:46:44 CST
2 second wait - while TWS connection process completes

****Called nextValidId 
$VAR1 = {
          'orderId' => '4520'
        };
ok 1 - Connected

****Called openOrder 
$VAR1 = {
          'orderId' => '4520',
          'contract' => {
                          'm_symbol' => 'MRK',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_right' => '?',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'MRK',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'order' => {
                       'm_orderId' => '4520',
                       'm_clientId' => '0',
                       'm_permId' => '183799287',
                       'm_action' => 'BUY',
                       'm_totalQuantity' => '100',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '34.81',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '183799287.0/U64/100',
                       'm_tif' => 'DAY',
                       'm_account' => 'U64',
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

****Called orderStatus 
$VAR1 = {
          'orderId' => '4520',
          'status' => 'Inactive',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '183799287',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4520',
          'contract' => {
                          'm_symbol' => 'MRK',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'MRK',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '4520',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601da.01.01',
                           'm_time' => '20060423  08:46:57',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '34.81',
                           'm_permId' => '183799287',
                           'm_liquidation' => '0'
                         }
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '4520',
          'status' => 'Filled',
          'filled' => '100',
          'remaining' => '0',
          'avgFillPrice' => '34.81',
          'permId' => '183799287',
          'parentId' => '0',
          'lastFillPrice' => '34.81',
          'clientId' => '0'
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '4520',
          'status' => 'Filled',
          'filled' => '100',
          'remaining' => '0',
          'avgFillPrice' => '34.81',
          'permId' => '183799287',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called openOrder 
$VAR1 = {
          'orderId' => '4521',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_right' => '?',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'F',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'order' => {
                       'm_orderId' => '4521',
                       'm_clientId' => '0',
                       'm_permId' => '183799288',
                       'm_action' => 'BUY',
                       'm_totalQuantity' => '3321',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '7.44',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '183799288.0/U64/100',
                       'm_tif' => 'DAY',
                       'm_account' => 'U64',
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

****Called orderStatus 
$VAR1 = {
          'orderId' => '4521',
          'status' => 'Inactive',
          'filled' => '0',
          'remaining' => '3321',
          'avgFillPrice' => '0.0',
          'permId' => '183799288',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4521',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'F',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '4521',
                           'm_clientId' => '0',
                           'm_execId' => '0000eff8.8895fff2.01.01',
                           'm_time' => '20060423  08:47:11',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'BOT',
                           'm_shares' => '2321',
                           'm_price' => '7.44',
                           'm_permId' => '183799288',
                           'm_liquidation' => '0'
                         }
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '4521',
          'status' => 'PendingSubmit',
          'filled' => '2321',
          'remaining' => '1000',
          'avgFillPrice' => '7.44',
          'permId' => '183799288',
          'parentId' => '0',
          'lastFillPrice' => '7.44',
          'clientId' => '0'
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4521',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'SMART',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'F',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '4521',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601de.01.01',
                           'm_time' => '20060423  08:47:12',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '1000',
                           'm_price' => '7.44',
                           'm_permId' => '183799288',
                           'm_liquidation' => '0'
                         }
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '4521',
          'status' => 'Filled',
          'filled' => '3321',
          'remaining' => '0',
          'avgFillPrice' => '7.44',
          'permId' => '183799288',
          'parentId' => '0',
          'lastFillPrice' => '7.44',
          'clientId' => '0'
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '4521',
          'status' => 'Filled',
          'filled' => '3321',
          'remaining' => '0',
          'avgFillPrice' => '7.44',
          'permId' => '183799288',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };
