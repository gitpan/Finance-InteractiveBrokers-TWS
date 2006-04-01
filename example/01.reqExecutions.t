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

