 package Local::Callback;
 use strict;
 
 sub new {
     bless {}, shift;
 }
 
 sub nextValidId {
     my $self = shift;
     $self->{nextValidId} = $_[0];
     print "nextValidId called with: ", join(" ", @_), "\n";
 }
 
 sub error {
     my ($self, $return_code, $error_num, $error_text) = @_;
 
     print "error called with: ", join('|', $return_code,
         $error_num, $error_text), "\n";
 
     # sleep for some predetermined time if I get a 502
     # Couldn't connect to TWS.  Confirm that "Enable ActiveX and
     # Socket Clients" is enabled on the TWS "Configure->API" menu.
    if ($error_num == 502) {
        sleep 60;
     }
 }
 
 sub AUTOLOAD {
     my ($self, @args) = @_;
     our $AUTOLOAD;
     print "$AUTOLOAD called with: ", join '^', @args, "\n";
     return;
 }
 
 package main;
 
 use Finance::InteractiveBrokers::TWS;
 
 my $tws;
 
 while (1) {
 
     if (defined $tws and $tws->isConnected) {
         $tws->process_messages(1);
     }
     else {
         connect_to_tws();
     }
 }
 
 $tws->eDisconnect;
 
 #   connect_to_tws, connects to the tws and sets up a few
 #   objects that we want clean at every new connection
 sub connect_to_tws {
 
     my $callback = Local::Callback->new();
     $tws = Finance::InteractiveBrokers::TWS->new($callback);
 
     ####                        Host         Port    Client_ID
     ####                        ----         ----    ---------
     my @tws_GUI_location = qw/  127.0.0.1    7496       15     /;
 
     $tws->eConnect(@tws_GUI_location);
 
     my $contract_id = 50;      # this can be any number you want
     my $contract    = $tws->Contract->new();
 
     $contract->{m_symbol}   = 'YHOO';
     $contract->{m_secType}  = 'STK';
     $contract->{m_exchange} = 'SMART';
 
     $tws->reqMktData($contract_id, $contract);
 
     $tws->process_messages(3);
 
     return;
 }
 
