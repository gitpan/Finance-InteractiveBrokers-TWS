package Finance::InteractiveBrokers::TWS;

use version; $VERSION = qv('0.0.5');

use warnings;
use strict;
use Carp;

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
);

use Object::InsideOut; 
{
    my @callback      :Field( Standard=>'callback'      );
    my @api           :Field( Get=>'get_api'            );
    my @EClientSocket :Field( Get=>'get_EClientSocket'  );
    
    my %init_args :InitArgs = (
        callback    => '',
    );

    sub _init :Init {
        my ($self, $args) = @_;

        my $api    = Finance::InteractiveBrokers::TWS::Inline_Bridge->new( 
                        $args->{callback}
                     );

        my $socket = $self->EClientSocket->new($api);
        
        $self->set(\@callback, $args->{callback});
        $self->set(\@api, $api);
        $self->set(\@EClientSocket, $socket);
    }
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

This document describes Finance::InteractiveBrokers::TWS 

=head1 SYNOPSIS

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

 my $connected = 0;

 while (1) {

     if ($connected) {
         process_queue();
     }
     else {
         connect_to_tws();
     }
 }

 #   connect_to_tws, connects to the tws and sets up a few 
 #   objects that we want clean at every new connection
 sub connect_to_tws {

     my $callback = Local::Callback->new();
     my $tws      = Finance::InteractiveBrokers::TWS->new(
                       callback => $callback
                    );

     my $client_socket = $tws->get_EClientSocket();
     my $api           = $tws->get_api();

     ####                        Host         Port    Client_ID
     ####                        ----         ----    ---------
     my @tws_GUI_location = qw/  127.0.0.1    7496       15     /;
     
     while (! $tws->get_EClientSocket->isConnected()) {
     
        $client_socket->eConnect(@tws_GUI_location);
     }

     $api->OpenCallbackStream();

     # spin until we get a nextValidId, that way we know the connection 
     # is complete
     while (! defined $callback->{nextValidId}) {
         process_queue($api);
     }

     #   Just process the queue for a little to make sure all connection 
     #   messages have been processed, otherwise if I interact with TWS 
     #   too early I get weird errors
     foreach (0..100) {
         process_queue($api);
     }

     my $contract_id = 50;      # this can be any number you want
     my $contract    = $tws->Contract->new();
     
     $contract->{m_symbol}   = 'YHOO';
     $contract->{m_secType}  = 'STK';
     $contract->{m_exchange} = 'SMART';

     $client_socket->reqMktData($contract_id, $contract);

     my $connected = 1;

     return;
 }

 #   process_queue, process all the current messages that have been sent 
 #   from the TWS at this point.  The callback will be called for each
 #   message in the queue
 sub process_queue {

     my ($api) = @_;

     while ($api->WaitForCallback(.05)) {  # .05 works good here, I had
         $api->ProcessNextCallback();      # problems with .01
     }

     return;
 }

=head1 DESCRIPTION

Finance::InteractiveBrokers::TWS - Is a wrapper around InteractiveBrokers Traders Workstation (TWS) Java interface, that lets one interact with the TWS using Perl, via the vendor supplied API.

It uses Inline::Java to wrap InteractiveBrokers' Java API that IB supplies to communicate with the TWS.  After numerous attempts at writing a pure perl module I opted for this solution because:

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

=head1 INTERFACE 

The interface is identical to the Java API supplied by InteractiveBrokers.  There are 2 interfaces to be exact.  The calling interface, i.e. the methods you call to send data to the TWS, and the callback interface, that is the data that is sent back to your custom event handler (callback).

I'm not going to document the interface (unless you make me) since InteractiveBrokers already did.

=head2 Calling Interface

IB's documentation is pretty weak.  But here is a list of methods you can call once you have created a Finance::InteractiveBrokers::TWS object

http://www.interactivebrokers.com/php/webhelp/Interoperability/Socket_Client_Java/java_eclientsocket.htm

=head2 Callback Interface

http://www.interactivebrokers.com/php/webhelp/Interoperability/Socket_Client_Java/java_ewrapper.htm

=head1 DIAGNOSTICS

C<< Finance::InteractiveBrokers::TWS::java::lang::NullPointerException=HASH(0x8b671cc) >> -  This means you did not supply a callback object when you instantiated a Finance::IB:TWS object.

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

=head1 SPECIAL THANKS

Patrick LeBoutillier - Author of Inline::Java, and for all his help while I learned how to use Inline::Java

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
