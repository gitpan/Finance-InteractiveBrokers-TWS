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

ok($tws->eConnect(pt, 7497, 0) >=1, 'Connected');

my $execution_filter = $tws->ExecutionFilter->new();

$tws->reqExecutions($execution_filter);


while (1) {
    $tws->process_messages(3);
}

$tws->eDisconnect();

__END__

Sort of a one time shot, in that it will report a list of current open orders and previous executions.  If any of those open orders get cancelled after the call, they get reported.  New orders or executions are not reported.

1..1
Server Version:26
TWS Time at connection:20060423 10:17:56 CST
2 second wait - while TWS connection process completes

****Called nextValidId 
$VAR1 = {
          'orderId' => '25718'
        };

****Called openOrder 
$VAR1 = {
          'orderId' => '25717',
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
                       'm_orderId' => '25717',
                       'm_clientId' => '0',
                       'm_permId' => '1855220090',
                       'm_action' => 'BUY',
                       'm_totalQuantity' => '100',
                       'm_orderType' => 'LMT',
                       'm_lmtPrice' => '7.35',
                       'm_auxPrice' => '0.0',
                       'm_sharesAllocation' => '1855220090.1/U77/100',
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

****Called orderStatus 
$VAR1 = {
          'orderId' => '25717',
          'status' => 'Submitted',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220090',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called openOrder 
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

****Called orderStatus 
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

****Called openOrder 
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

****Called orderStatus 
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

****Called execDetails 
$VAR1 = {
          'orderId' => '4521',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
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

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960195.01.01',
                           'm_time' => '20060423  08:19:57',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '7.44',
                           'm_permId' => '183799202',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'INTC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960177.01.01',
                           'm_time' => '20060423  07:52:58',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '19.1',
                           'm_permId' => '183799148',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '25754',
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '25754',
                           'm_clientId' => '10',
                           'm_execId' => '0000efd5.88960205.01.01',
                           'm_time' => '20060423  09:14:16',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '1000',
                           'm_price' => '27.02',
                           'm_permId' => '183799294',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '25714',
          'contract' => {
                          'm_symbol' => 'GE',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '25714',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960225.01.01',
                           'm_time' => '20060423  09:32:40',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '33.79',
                           'm_permId' => '183799301',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '25767',
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '25767',
                           'm_clientId' => '10',
                           'm_execId' => '0000efd5.88960207.01.01',
                           'm_time' => '20060423  09:14:40',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '700',
                           'm_price' => '27.03',
                           'm_permId' => '183799295',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'INTC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960179.01.01',
                           'm_time' => '20060423  07:52:58',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '2900',
                           'm_price' => '19.1',
                           'm_permId' => '183799148',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'CSC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601f3.01.01',
                           'm_time' => '20060423  09:09:19',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '59.11',
                           'm_permId' => '183799289',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000eff8.8895ff80.01.01',
                           'm_time' => '20060423  07:59:51',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'IBM',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601f5.01.01',
                           'm_time' => '20060423  09:11:19',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '82.02',
                           'm_permId' => '183799292',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'GE',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960249.01.01',
                           'm_time' => '20060423  09:53:47',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '33.79',
                           'm_permId' => '183799336',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000eff8.8895ff82.01.01',
                           'm_time' => '20060423  07:59:54',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'CSC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000eff8.8895ff86.01.01',
                           'm_time' => '20060423  08:25:55',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '58.79',
                           'm_permId' => '183799262',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'MSFT',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896016d.01.01',
                           'm_time' => '20060423  07:25:54',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '27.15',
                           'm_permId' => '183799146',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4521',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
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

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'INTC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896018d.01.01',
                           'm_time' => '20060423  08:09:03',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'SLD',
                           'm_shares' => '100',
                           'm_price' => '19.11',
                           'm_permId' => '183799152',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960180.01.01',
                           'm_time' => '20060423  07:59:48',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '200',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000eff8.8895ff7c.01.01',
                           'm_time' => '20060423  07:59:46',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960182.01.01',
                           'm_time' => '20060423  07:59:52',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '200',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000eff8.8895ff7e.01.01',
                           'm_time' => '20060423  07:59:48',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'CSC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960250.01.01',
                           'm_time' => '20060423  09:56:19',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '58.84',
                           'm_permId' => '183799338',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960184.01.01',
                           'm_time' => '20060423  07:59:56',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '200',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'MRK',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960196.01.01',
                           'm_time' => '20060423  08:24:44',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '34.81',
                           'm_permId' => '183799241',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960186.01.01',
                           'm_time' => '20060423  07:59:59',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '32',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'INTC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960168.01.01',
                           'm_time' => '20060423  07:25:36',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '19.15',
                           'm_permId' => '183799144',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4518',
          'contract' => {
                          'm_symbol' => 'IBM',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '4518',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601d2.01.01',
                           'm_time' => '20060423  08:42:36',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '81.98',
                           'm_permId' => '183799285',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4519',
          'contract' => {
                          'm_symbol' => 'IBM',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '4519',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601d6.01.01',
                           'm_time' => '20060423  08:46:30',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '82.0',
                           'm_permId' => '183799286',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'MSFT',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.88960208.01.01',
                           'm_time' => '20060423  09:17:56',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '27.34',
                           'm_permId' => '183799299',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.889601a8.01.01',
                           'm_time' => '20060423  08:26:31',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '7.46',
                           'm_permId' => '183799263',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'INTC',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896017a.01.01',
                           'm_time' => '20060423  07:55:30',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '4300',
                           'm_price' => '19.12',
                           'm_permId' => '183799153',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896016a.01.01',
                           'm_time' => '20060423  07:25:47',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '33.51',
                           'm_permId' => '183799145',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896017c.01.01',
                           'm_time' => '20060423  07:59:46',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '200',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'YHOO',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896017e.01.01',
                           'm_time' => '20060423  07:59:47',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '200',
                           'm_price' => '33.42',
                           'm_permId' => '183799159',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'GE',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896024a.01.01',
                           'm_time' => '20060423  09:54:05',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '33.81',
                           'm_permId' => '183799337',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '0',
          'contract' => {
                          'm_symbol' => 'MSFT',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '0',
                           'm_clientId' => '0',
                           'm_execId' => '0000efd5.8896018e.01.01',
                           'm_time' => '20060423  08:13:36',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ISLAND',
                           'm_side' => 'BOT',
                           'm_shares' => '100',
                           'm_price' => '27.28',
                           'm_permId' => '183799183',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '25767',
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ARCA',
                          'm_currency' => 'USD',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'execution' => {
                           'm_orderId' => '25767',
                           'm_clientId' => '10',
                           'm_execId' => '0000eff8.8895fff5.01.01',
                           'm_time' => '20060423  09:14:39',
                           'm_acctNumber' => 'U64',
                           'm_exchange' => 'ARCA',
                           'm_side' => 'SLD',
                           'm_shares' => '300',
                           'm_price' => '27.03',
                           'm_permId' => '183799295',
                           'm_liquidation' => '0'
                         }
        };

****Called execDetails 
$VAR1 = {
          'orderId' => '4520',
          'contract' => {
                          'm_symbol' => 'MRK',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_exchange' => 'ISLAND',
                          'm_currency' => 'USD',
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

****Called error 
$VAR1 = {
          'id' => '25716',
          'errorCode' => '202',
          'errorMsg' => 'Order Canceled - reason:'
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '25716',
          'status' => 'Cancelled',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220089',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called error 
$VAR1 = {
          'id' => '25717',
          'errorCode' => '202',
          'errorMsg' => 'Order Canceled - reason:'
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '25717',
          'status' => 'Cancelled',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220090',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };

****Called error 
$VAR1 = {
          'id' => '25715',
          'errorCode' => '202',
          'errorMsg' => 'Order Canceled - reason:'
        };

****Called orderStatus 
$VAR1 = {
          'orderId' => '25715',
          'status' => 'Cancelled',
          'filled' => '0',
          'remaining' => '100',
          'avgFillPrice' => '0.0',
          'permId' => '1855220088',
          'parentId' => '0',
          'lastFillPrice' => '0.0',
          'clientId' => '0'
        };
