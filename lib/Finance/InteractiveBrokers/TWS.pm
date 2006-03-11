package Finance::InteractiveBrokers::TWS;

use version; $VERSION = qv('0.0.6');

use warnings;
use strict;
use Carp;

#   Define comp_dir to hold the location for where we 
#   want Inline::Java to complile its Java files.  Otherwise
#   Inline will create them in the pwd of the executed script
my $comp_dir;

BEGIN {
    use Config;
    use File::Spec;
    $comp_dir = File::Spec->catfile(
        $Config{sitelib},
        split(/::/,__PACKAGE__),
        "_Inline",
    );
}

use Inline (
    Java        => "DATA",
    JNI         => 1,
    AUTOSTUDY   => 1,
    STUDY => [ 
              'com.ib.client.ComboLeg',
              'com.ib.client.ContractDetails',
              'com.ib.client.Contract',
              'com.ib.client.EClientSocket',
              'com.ib.client.ExecutionFilter',
              'com.ib.client.Execution',
              'com.ib.client.Order',
              'com.ib.client.ScannerSubscription',
             ],
    # complile Java in specific directory
    DIRECTORY => $comp_dir,  
);

#   A hash of method names that TWS API (from IB) currently supports.  If a 
#   new one is added in a later version of TWS, simply add it to this hash
#   
my %sub_of = (
    cancelScannerSubscription => 1,
    reqScannerParameters => 1,
    reqScannerSubscription => 1,
    reqMktData => 1,
    cancelHistoricalData => 1,
    reqHistoricalData => 1,
    reqContractDetails => 1,
    reqMktDepth => 1,
    cancelMktData => 1,
    cancelMktDepth => 1,
    exerciseOptions => 1,
    placeOrder => 1, 
    reqAccountUpdates => 1,
    reqExecutions => 1,
    cancelOrder => 1,
    reqOpenOrders => 1,
    reqIds => 1,
    reqNewsBulletins => 1,
    cancelNewsBulletins => 1,
    setServerLogLevel => 1,
    reqAutoOpenOrders => 1,
    reqAllOpenOrders => 1,
    reqManagedAccts => 1,
    requestFA => 1,
    replaceFA => 1,
);

use Object::InsideOut; 
{

    my @callback      :Field( Get      =>'callback'          );
    my @api           :Field( Get      =>'get_api'           );
    my @EClientSocket :Field( Get      =>'get_EClientSocket' );
    
    my %init_args :InitArgs = (
        callback    => { Field=>\@callback, Mandatory => 1 },
    );

    sub _init :Init {
        my ($self, $args) = @_;

        my $api    = Finance::InteractiveBrokers::TWS::Inline_Bridge->new( 
                        $callback[$$self]
                     );

        my $socket = $self->EClientSocket->new($api);
        
        $self->set(\@api, $api);
        $self->set(\@EClientSocket, $socket);
    }
 
    # A wrapper around Object::InsideOut's ->new() method just to 
    # simplify the call to this module as a single parm call as opposed 
    # to using a hash
    sub new { 
	    my ($class, $callback) = @_;
	    return $class->Object::InsideOut::new(callback => $callback);
    }
}

sub eConnect {

    my $self     = shift;
    my ($host, $port, $client_id) = @_;

    $host      ||= 'localhost';
    $port      ||= 7496;
    $client_id ||= $$;

    my $client_socket = $self->get_EClientSocket();

    $client_socket->eConnect($host, $port, $client_id);

    $self->get_api->OpenCallbackStream();

    my $wait = 2;
    print "$wait second wait - while TWS connection process completes\n";
    $self->process_messages($wait);

    return $self->isConnected();
}

sub eDisconnect {
    my $self = shift;
    $self->get_EClientSocket->eDisconnect();
    $self->process_messages();
    
    return ! $self->isConnected(); # negate so that returns true on success
}

sub isConnected {
    my $self = shift;
    return $self->get_EClientSocket->isConnected();
}

sub process_messages {

    my ($self, $wait) = @_;

    $wait ||= .05;
    my $api = $self->get_api();

    while ($api->WaitForCallback($wait)) {
        $api->ProcessNextCallback();
    }
    
    return;
}

sub AUTOLOAD {
    my $self = shift;
    my @args = @_;

    our $AUTOLOAD;

    my $sub_name = $AUTOLOAD;
    $sub_name =~ s/^.*:://;

    my $ec = $self->get_EClientSocket;

    if (defined $sub_of{$sub_name}) {
        $ec->$sub_name(@_);
    }
    else {
        $self->eDisconnect();
        croak "no method: $sub_name defined\n";
    }

    return;
}

#   Simple stubs to as shortcuts to the IB Java objects
#   
sub ComboLeg {
    return __PACKAGE__.'::com::ib::client::ComboLeg';
}

sub ContractDetails {
    return __PACKAGE__.'::com::ib::client::ContractDetails';
}

sub Contract {
    return __PACKAGE__.'::com::ib::client::Contract';
}

sub EClientSocket {
    return __PACKAGE__.'::com::ib::client::EClientSocket';
}

sub ExecutionFilter {
    return __PACKAGE__.'::com::ib::client::ExecutionFilter';
}

sub Execution {
    return __PACKAGE__.'::com::ib::client::Execution';
}

sub Order {
    return __PACKAGE__.'::com::ib::client::Order';
}

sub ScannerSubscription {
    return __PACKAGE__.'::com::ib::client::ScannerSubscription';
}

1;

__DATA__
__Java__

import org.perl.inline.java.*;
import com.ib.client.*;


class Inline_Bridge extends InlineJavaPerlCaller implements EWrapper {

    InlineJavaPerlObject perlobj;

    public Inline_Bridge(InlineJavaPerlObject PerlObj) 
    throws InlineJavaException {
        perlobj = PerlObj;
    }

    public void tickPrice(int tickerId, int field, double price, 
                          int canAutoExecute) 
    
    {
        try {
            perlobj.InvokeMethod("tickPrice", new Object [] {
                    tickerId, field, price, canAutoExecute
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }

    public void tickSize(int tickerId, int field, int size) 
    {
        try {
            perlobj.InvokeMethod("tickSize", new Object [] {
                    tickerId, field, size
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void orderStatus(int orderId, String status, int filled, 
                            int remaining, double avgFillPrice, int permId, 
                            int parentId, double lastFillPrice, int clientId) 
    {
        try {
            perlobj.InvokeMethod("orderStatus", new Object [] {
                orderId, status, filled, remaining, avgFillPrice,
                permId, parentId, lastFillPrice, clientId
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void openOrder(int orderId, Contract contract, Order order) 
    {
        try {
            perlobj.InvokeMethod("openOrder", new Object [] {
                orderId, contract, order
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void error(String str) 
    {
        try {
            perlobj.InvokeMethod("error", new Object [] {
                str
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void connectionClosed() 
    {
        try {
            perlobj.InvokeMethod("connectionClosed", new Object [] {
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    
    }
    
	public void updateAccountValue(String key, String value, String currency, 
                                   String accountName) 
    {
        try {
            perlobj.InvokeMethod("updateAccountValue", new Object [] {
                key, value, currency, accountName
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    
    }

    public void updatePortfolio(Contract contract, int position, 
                                double marketPrice, double marketValue,
                                double averageCost, double unrealizedPNL, 
                                double realizedPNL, String accountName) {
        try {
            perlobj.InvokeMethod("updatePortfolio", new Object [] {
                contract, position, marketPrice, marketValue,
                averageCost, unrealizedPNL, realizedPNL, accountName
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void updateAccountTime(String timeStamp) {
        try {
            perlobj.InvokeMethod("tickPrice", new Object [] {
                    timeStamp
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
    public void nextValidId(int orderId) 
    {
        try {
            perlobj.InvokeMethod("nextValidId", new Object [] {
                orderId
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
	
    public void contractDetails(ContractDetails contractDetails) 
    {
        try {
            perlobj.InvokeMethod("contractDetails", new Object [] {
                contractDetails
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void bondContractDetails(ContractDetails contractDetails) 
    {
        try {
            perlobj.InvokeMethod("bondContractDetails", new Object [] {
                contractDetails
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void execDetails(int orderId, Contract contract, 
                            Execution execution) {
    
        try {
            perlobj.InvokeMethod("execDetails", new Object [] {
                orderId, contract, execution
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void error(int id, int errorCode, String errorMsg) 
    {
        try {
            perlobj.InvokeMethod("error", new Object [] {
                id, errorCode, errorMsg
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void updateMktDepth(int tickerId, int position, int operation, 
                               int side, double price, int size) 
    {
        try {
            perlobj.InvokeMethod("updateMktDepth", new Object [] {
                tickerId, position, operation, side, price, size
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void updateMktDepthL2(int tickerId, int position, 
                                 String marketMaker, int operation, int side, 
                                 double price, int size) 
    {
        try {
            perlobj.InvokeMethod("updateMktDepthL2", new Object [] {
                tickerId, position, marketMaker, operation,
                side, price, size
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void updateNewsBulletin(int msgId, int msgType, String message, 
                                   String origExchange) 
    {
        try {
            perlobj.InvokeMethod("updateNewsBulletin", new Object [] {
                msgId, msgType, message, origExchange
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void managedAccounts(String accountsList) 
    {
        try {
            perlobj.InvokeMethod("managedAccounts", new Object [] {
                accountsList
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void receiveFA(int faDataType, String xml) 
    {
        try {
            perlobj.InvokeMethod("receiveFA", new Object [] {
                faDataType, xml
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}

    }
	
    public void historicalData(int reqId, String date, double open, 
                               double high, double low, double close, 
                               int volume, double WAP, boolean hasGaps) 
    {
        try {
            perlobj.InvokeMethod("historicalData", new Object [] {
                reqId, date, open, high, low,
                close, volume, WAP, hasGaps
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
	
    public void scannerParameters(String xml) {
        try {
            perlobj.InvokeMethod("scannerParameters", new Object [] {
                xml
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void scannerData(int reqId, int rank, 
                            ContractDetails contractDetails, String distance, 
                            String benchmark, String projection) {
        try {
            perlobj.InvokeMethod("scannerData", new Object [] {
                reqId, rank, contractDetails, distance,
                benchmark, projection
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
}

__END__

=head1 NAME

Finance::InteractiveBrokers::TWS - Lets you talk to Interactivebrokers Trader's Workstation using Perl.

This module is a wrapper around InteractiveBroker's Trader's Workstation (TWS) Java interface, that lets one interact with the TWS using Perl, via the vendor supplied API.  This means that all the functionality available to Java programmers is also available to you.

=head1 VERSION

0.0.6 - Still Alpha since bugs are being found and the interface is changing.  But all in all it seems to work quite nicely

=head1 SYNOPSIS

=head2 Methods implemented by Finance::InteractiveBrokers::TWS

 use Finance::InteractiveBrokers::TWS;
 
 my $tws = Finance::InteractiveBrokers::TWS->new(callback=>$callback);
 
 my $callback         = $tws->get_callback();
 my $rc               = $tws->eConnect($host, $port, $client_id);
 my $rc               = $tws->eDisconnect();
 my $rc               = $tws->isConnected(@parms);
 my $rc               = $tws->process_messages($seconds_to_wait);

=head2 Shortcuts for instantiating IB Java classes

 my $combo_leg        = $tws->ComboLeg->new(@parms);
 my $contract_details = $tws->ContractDetails->new(@parms);
 my $contract         = $tws->Contract->new(parms);
 my $execution_filter = $tws->ExecutionFilter->new(@parms);
 my $execution        = $tws->Execution->new(@parms);
 my $order            = $tws->Order->new(@parms);
 my $scanner_sub      = $tws->ScannerSubscription->new(@parms);

=head2 Shortcuts for asking TWS to do something for you
  
 $tws->cancelHistoricalData(@parms);
 $tws->cancelMktData(@parms);
 $tws->cancelMktDepth(@parms);
 $tws->cancelNewsBulletins(@parms);
 $tws->cancelOrder(@parms);
 $tws->cancelScannerSubscription(@parms);
 $tws->exerciseOptions(@parms);
 $tws->placeOrder(@parms);
 $tws->replaceFA(@parms);
 $tws->reqAccountUpdates(@parms);
 $tws->reqAllOpenOrders(@parms);
 $tws->reqAutoOpenOrders(@parms);
 $tws->reqContractDetails(@parms);
 $tws->reqExecutions(@parms);
 $tws->reqHistoricalData(@parms);
 $tws->reqIds(@parms);
 $tws->reqManagedAccts(@parms);
 $tws->reqMktData(@parms);
 $tws->reqMktDepth(@parms);
 $tws->reqNewsBulletins(@parms);
 $tws->reqOpenOrders(@parms);
 $tws->reqScannerParameters(@parms);
 $tws->reqScannerSubscription(@parms);
 $tws->requestFA(@parms);
 $tws->setServerLogLevel(@parms);

=head1 DESCRIPTION

Finance::InteractiveBrokers::TWS - Is a wrapper around InteractiveBrokers Traders Workstation (TWS) Java interface, that lets one interact with the TWS using Perl, via the vendor supplied API.

It uses Inline::Java to wrap InteractiveBrokers' Java API that IB supplies to communicate with the TWS.  As such, the method names don't conform to Perl standards and in most cases follow Java standards.

After numerous attempts at writing a pure perl module I opted for this solution because:

=over 

=item * 

Using Inline::Java resulted in a much simpler and smaller module

=item * 

The interaction and call syntax is identical to the Java API (because it is the Java API) and as such, you can ask questions on the IB bulletin board and yahoo, and be using the same method names and call syntax as they are.  In other words, people will know what you're talking about.

=item * 

IB changes their interface with some frequency, which required re-writing my interface every time 

=item * 

IB changes there message stream, which required me to modify my parser

=item * 

Whenever IB changes something I'd have to diff the old API versus the new API and try to figure out what changed and how that affected my code 

=back

=head2 Class methods

The following methods are provided by the Finance::InteractiveBrokers::TWS class

=head3 new

Sorta obvious, this instantiates an object of class Finance::InteractiveBrokers::TWS.  It requires a single parameter: a callback object.  That is, you (the user) has to write an class that can handle messages that the TWS will send to this client.

 my $tws = Finance::InteractiveBrokers::TWS->new($callback);

=head3 get_callback

Simply returns the callback you supplied when you instantiated this class.  Provided in case you need to pass around your $tws and want to access data you might have cached away in your callback

 my $callback = $tws->get_callback();


=head3 eConnect

Establishes (or tries to) a connection to the TWS defined in its parameters.  It accepts 3 parameters: 

=over 4

=item 1 IP address or Host name - DEFAULTS to localhost

=item 2 The port upon which TWS is accepting connections - DEFAULTS to 7496

=item 3 The client ID - DEFAULTS to process id

=back

 my $boolean = $tws->eConnect($host, $port, $client_id)

=head3 eDisconnect

Disconnects from the TWS, and returns a boolean of success or failure in disconnection.

 my $booean = $tws->eDisconnect();

=head3 isConnected

Returns a boolean of whether or not you are currently connected to the TWS

 my $boolean = $tws->isConnected();

=head3 process_messages

Processes the messages the TWS has emitted.  It accepts a single optional parameter of how many seconds to listen for messages to process.  If no messages are found within the wait period, control is returned to the caller.

 my $seconds_to_wait = 2;
 $tws->process_messages($seconds_to_wait);

=head2 Java methods

The following methods are not implemented by Finance::InteractiveBrokers::TWS, but instead are accessed thru your $tws and implemented by the IB published API. The obvious benefit is I have to do less work.  The other benefit (probably more important to you) is that when IB changes things this code continues to work.

IB's documentation is pretty weak.  But here is a link to IBs website with a list of methods you can call once you have created a Finance::InteractiveBrokers::TWS object

http://www.interactivebrokers.com/php/webhelp/Interoperability/Socket_Client_Java/java_eclientsocket.htm

=head3 cancelHistoricalData

 $tws->cancelHistoricalData(@parms);

=head3 cancelMktData

 $tws->cancelMktData(@parms);

=head3 cancelMktDepth

 $tws->cancelMktDepth(@parms);

=head3 cancelNewsBulletins

 $tws->cancelNewsBulletins(@parms);

=head3 cancelOrder

 $tws->cancelOrder(@parms);

=head3 cancelScannerSubscription

 $tws->cancelScannerSubscription(@parms);

=head3 exerciseOptions

 $tws->exerciseOptions(@parms);

=head3 placeOrder

 $tws->placeOrder(@parms);

=head3 replaceFA

 $tws->replaceFA(@parms);

=head3 reqAccountUpdates

 $tws->reqAccountUpdates(@parms);

=head3 reqAllOpenOrders

 $tws->reqAllOpenOrders(@parms);

=head3 reqAutoOpenOrders

 $tws->reqAutoOpenOrders(@parms);

=head3 reqContractDetails

 $tws->reqContractDetails(@parms);

=head3 reqExecutions

 $tws->reqExecutions(@parms);

=head3 reqHistoricalData

 $tws->reqHistoricalData(@parms);

=head3 reqIds

 $tws->reqIds(@parms);

=head3 reqManagedAccts

 $tws->reqManagedAccts(@parms);

=head3 reqMktData

 $tws->reqMktData(@parms);

=head3 reqMktDepth

 $tws->reqMktDepth(@parms);

=head3 reqNewsBulletins

 $tws->reqNewsBulletins(@parms);

=head3 reqOpenOrders

 $tws->reqOpenOrders(@parms);

=head3 reqScannerParameters

 $tws->reqScannerParameters(@parms);

=head3 reqScannerSubscription

 $tws->reqScannerSubscription(@parms);

=head3 requestFA

 $tws->requestFA(@parms);

=head3 setServerLogLevel

 $tws->setServerLogLevel(@parms);


=head2 Creating Java Objects

In addition to the methods described just above.  There are some additional methods available for creating the other IB Java objects necessary for interacting with the TWS.

=head3 Instantiating

When instantiating these objects you can pass all the parameters in positionally according to how IB has documented them.  Or you can just create them blank and set the attributes later.

 my $ComboLeg            = $tws->ComboLeg->new(@parms);
 
 my $Contract            = $tws->Contract->new(@parms);
 
 my $ContractDetails     = $tws->ContractDetails->new(@parms);
 
 my $EClientSocket       = $tws->EClientSocket->new(@parms);

 my $Execution           = $tws->Execution->new(@parms);

 my $ExecutionFilter     = $tws->ExecutionFilter->new(@parms);
 
 my $Order               = $tws->Order->new(@parms);

 my $ScannerSubscription = $tws->ScannerSubscription->new(@parms);

If you find that IB publishes a new Java object that you need to use and it's not included above, you can still use the new object.  The above list is really just a shortcut for doing it the long way.  Such as:

 my $order = Finance::InteractiveBrokers::TWS::com::ib::client::ComboLeg->new();

=head3 Set/Get

When Inline::Java creates these objects it hands back a Perl reference to hash.  Thus working with these objects is simple.  To set a attribute of an object you do it like:

 $contract->{m_symbol}   = 'YHOO';

To get an attribute of an object you do it like:

 my $symbol = $contract->{m_symbol};

=head1 CALLBACK

The callback is the custom code you write to handle the messages the TWS emits and that are picked up by the API.  The API dispatches (call) your callback to handle processing of the message.

The methods that are called are described (poorly) by IB at:

http://www.interactivebrokers.com/php/webhelp/Interoperability/Socket_Client_Java/java_ewrapper.htm

But in general, you will have methods in your callback like:

 sub tickPrice {
    my ($self, @args) = @_;
    
    # do something when you get a change in price
 }

 sub error {
    my ($self, @args) = @_;

    # handle the error
 }

Again, these methods are described by IB on their website.

=head1 EXAMPLE

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
 
     if (defined $tws and $tws->isCconnected) {
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
     #my @tws_GUI_location = qw/  127.0.0.1    7496       15     /;
     my @tws_GUI_location = qw/  pt    7496       15     /;
 
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
 
=head1 HELP

You are welcome to email me if you are having problems with this module.  You should also look at the IB forums (http://www.interactivebrokers.com/cgi-bin/discus/discus.pl) if you have questions about interacting with the TWS (i.e. how to get TWS to do something for you, what the proper call syntax is...)

There is also another forum on: http://finance.groups.yahoo.com/group/TWSAPI . I'm not exactly sure of what the difference is.

There is a Wiki for TWS at: http://chuckcaplan.com/twsapi/

=head1 DIAGNOSTICS

 Finance::InteractiveBrokers::TWS::java::lang::NullPointerException=HASH(0x8b671cc)
 
This means you did not supply a callback object when you instantiated a Finance::IB:TWS object.

 The error message was:
 TWS_661f.java:21: incompatible types
 found   : int
 required: java.lang.Object
                     tickerId, field, price, canAutoExecute
                     ^

The above error is sort of a bug, sort of an inconsistancy.  But basically if you are running Java <= 1.4 then you need to alter the TWS.pm source and change the lines that look like:

 perlobj.InvokeMethod("tickPrice", new Object [] {
                       tickerId, field, price, canAutoExecute
                      });

and manually cast the variables into their types directly, like this:

 perlobj.InvokeMethod("tickPrice", new Object [] {
    new Integer (tickerId), new Integer (field), new Double (price), 
    new Integer (canAutoExecute)});

I don't feel like going through all the code to do this, especially since most
people will be using Java 1.5 and above shortly

=head1 CONFIGURATION AND ENVIRONMENT

You need to compile the *.java API source files into java class files prior to using this module.  Do it like:

 $ cd ~/IBJts/java/com/ib/client/
 $ javac *.java

Furthermore Finance::InteractiveBrokers::TWS does require that you set your CLASSPATH environmental variable to the location of the IBJts/java directory where you installed the IB API.  Such as:

 $ export CLASSPATH=~/IBJts/java

=head1 DEPENDENCIES

=over

=item * 

Java SDK

=item *

InteractiveBrokers TWS GUI application

=item * 

Inline::Java v.50_92 or greater

=back

=head1 INCOMPATIBILITIES

See above DIAGNOSTICS

=head1 BUGS AND LIMITATIONS

See above DIAGNOSTICS

Please report any bugs or feature requests to
C<bug-finance-ib-tws@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 VERY SPECIAL THANKS

Patrick LeBoutillier - Author of Inline::Java, and for all his help while I learned how to use Inline::Java

=head1 ACKNOWLEDGEMENTS

Carl Erickson wrote the first Perl interface. Based on his README, it was sort of a proof of concept, and doesn't implement all of TWS's functionality. Carl is pretty active on the TWS mailing list(s). He doesn't actively "support" the perl code, but he's very helpful if you want to try it and need some help. This code is meant to be synchronous and blocking; in that you request market data, and your program blocks until you get the data back. Every time you want new data, you request it.

You can find the code on the Yahoo TWSAPI group, I think the following link will work: http://finance.groups.yahoo.com/group/TWSAPI/files/Perl%20Code/

=head1 AUTHOR

Jay Strauss  C<< <tws_at_heyjay.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2006, Jay Strauss C<< <tws_at_heyjay.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
