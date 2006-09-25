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

my $order_id = $$;

$tws->reqAccountUpdates(1,undef);

while (1) {
    $tws->process_messages(3);
}

$tws->eDisconnect();

__END__

1..1
Server Version:25
TWS Time at connection:20060327 07:55:25 CST
2 second wait - while TWS connection process completes

****Called nextValidId 
$VAR1 = {
          'orderId' => '26810'
        };

****Called error 
$VAR1 = {
          'id' => '-1',
          'errorCode' => '2104',
          'errorMsg' => 'Market data farm connection is OK:usfarm'
        };
ok 1 - Connected

****Called updateAccountValue 
$VAR1 = {
          'key' => 'EquityWithLoanValue',
          'value' => '100860.37',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'Currency',
          'value' => 'USD',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AvailableFunds',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'DayTradesRemainingT+4',
          'value' => '-1',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'SMA',
          'value' => '1408.49',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FuturesPNL',
          'value' => '0.00',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AccountType',
          'value' => 'UNIVERSAL',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadInitMarginReq',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'TotalCashValue-S',
          'value' => '-99549.82',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadAvailableFunds',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'ExcessLiquidity-S',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullAvailableFunds-S',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AccruedCash',
          'value' => '0.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'MaintMarginReq',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadMaintMarginReq',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AccountReady',
          'value' => 'true',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadMaintMarginReq-S',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'UnrealizedPnL',
          'value' => '631.16',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'ExcessLiquidity',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'Leverage-S',
          'value' => '1.99',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AvailableFunds-S',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'UnrealizedPnL',
          'value' => '631.16',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'OptionMarketValue',
          'value' => '0.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'TotalCashBalance',
          'value' => '-99549.82',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullMaintMarginReq-S',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'StockMarketValue',
          'value' => '200410.19',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'MaintMarginReq-S',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FuturesPNL',
          'value' => '0.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'DayTradesRemaining',
          'value' => '-1',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AccruedCash',
          'value' => '0.00',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'ExchangeRate',
          'value' => '1.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'Cushion',
          'value' => '0.503248',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadNextChange',
          'value' => '0',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'RealizedPnL',
          'value' => '0.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'CashBalance',
          'value' => '-99549.82',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'UnalteredInitMarginReq',
          'value' => '-1.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'StockMarketValue',
          'value' => '200410.19',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullExcessLiquidity-S',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'RealizedPnL',
          'value' => '0.00',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullExcessLiquidity',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'InitMarginReq',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'PreviousDayEquityWithLoanValue-S',
          'value' => '100137.39',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'ExchangeRate',
          'value' => '1.00',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'PreviousDayEquityWithLoanValue',
          'value' => '100137.39',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullMaintMarginReq',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'Currency',
          'value' => 'BASE',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'PNL',
          'value' => 'true',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullInitMarginReq',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FutureOptionValue',
          'value' => '0.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'NetLiquidationByCurrency',
          'value' => '100860.37',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'GrossPositionValue-S',
          'value' => '200410.19',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'SMA-S',
          'value' => '1408.49',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'OptionMarketValue',
          'value' => '0.00',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'TotalCashValue',
          'value' => '-99549.82',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'GrossPositionValue',
          'value' => '200410.19',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullAvailableFunds',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'BuyingPower',
          'value' => '200139.37',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'NetLiquidation',
          'value' => '100860.37',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadExcessLiquidity-S',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadInitMarginReq-S',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'DayTradesRemainingT+1',
          'value' => '-1',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'NetLiquidation-S',
          'value' => '100860.37',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AccountCode',
          'value' => 'DU8655',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FullInitMarginReq-S',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadAvailableFunds-S',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'DayTradesRemainingT+2',
          'value' => '-1',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'FutureOptionValue',
          'value' => '0.00',
          'currency' => 'BASE',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'NetLiquidationByCurrency',
          'value' => '100860.37',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'CashBalance',
          'value' => '-99549.82',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'InitMarginReq-S',
          'value' => '50102.55',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'UnalteredMaintMarginReq',
          'value' => '-1.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'EquityWithLoanValue-S',
          'value' => '100860.37',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'DayTradesRemainingT+3',
          'value' => '-1',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'TotalCashBalance',
          'value' => '-99549.82',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'AccruedCash-S',
          'value' => '0.00',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountValue 
$VAR1 = {
          'key' => 'LookAheadExcessLiquidity',
          'value' => '50757.83',
          'currency' => 'USD',
          'accountName' => 'DU8655'
        };

****Called updateAccountTime 
$VAR1 = {
          'timeStamp' => '07:48'
        };

****Called updatePortfolio 
$VAR1 = {
          'contract' => {
                          'm_symbol' => 'DELL',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'DELL',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'position' => '5511',
          'marketPrice' => '30.2',
          'marketValue' => '166432.19',
          'averageCost' => '30.049',
          'unrealizedPNL' => '833.16',
          'realizedPNL' => '0.0',
          'accountName' => 'DU8655'
        };

****Called updateAccountTime 
$VAR1 = {
          'timeStamp' => '07:48'
        };

****Called updatePortfolio 
$VAR1 = {
          'contract' => {
                          'm_symbol' => 'F',
                          'm_secType' => 'STK',
                          'm_strike' => '0.0',
                          'm_currency' => 'USD',
                          'm_localSymbol' => 'F',
                          'm_callable' => '0',
                          'm_putable' => '0',
                          'm_coupon' => '0.0',
                          'm_convertible' => '0'
                        },
          'position' => '4200',
          'marketPrice' => '8.09',
          'marketValue' => '33978.0',
          'averageCost' => '8.138',
          'unrealizedPNL' => '-202.0',
          'realizedPNL' => '0.0',
          'accountName' => 'DU8655'
        };

****Called updateAccountTime 
$VAR1 = {
          'timeStamp' => '07:48'
        };

****Called updateAccountTime 
$VAR1 = {
          'timeStamp' => '07:54'
        };
