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

    my $nothing = bless {}, 'nothing';
    my $tws = Finance::InteractiveBrokers::TWS->new($nothing);
    
    $tws->dump_event($sub_name, \@args);
    #$self->{tws}->dump_event($sub_name, \@args);

    return;

}

package main;

use Finance::InteractiveBrokers::TWS;
use Test::More tests => 1;

my $callback = Local::Callback->new();

my $tws = Finance::InteractiveBrokers::TWS->new($callback);

$callback->{tws} = $tws;

ok($tws->eConnect(pt, 7497, 0) >=1, 'Connected');

my $contract_id = $$;

#   Create a contract
#
my $contract = $tws->Contract->new();
$contract->{m_symbol} = 'DELL';
$contract->{m_secType} = 'STK';
$contract->{m_exchange} = 'SMART';

$tws->reqMktDepth($contract_id, $contract, 10);

while (1) {
    $tws->process_messages(3);
}

$tws->eDisconnect();

__END__

