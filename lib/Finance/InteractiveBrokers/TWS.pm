package Finance::InteractiveBrokers::TWS;

use version; $VERSION = qv('0.0.2');

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
    my @host          :Field( Standard=>'host'          );
    my @port          :Field( Standard=>'port'          );
    my @client_ID     :Field( Standard=>'client_ID'     );
    my @callback      :Field( Standard=>'callback'      );
    my @api           :Field( Get=>'get_api'            );
    my @EClientSocket :Field( Get=>'get_EClientSocket'  );
    
    my %init_args :InitArgs = (
        host        => '',
        port        => '',
        client_ID   => '',
        callback    => '',
    );

    sub _init :Init {
        my ($self, $args) = @_;

        $self->set(\@host, exists $args->{host} ? $args->{host} : '127.0.0.1');
        $self->set(\@port, exists $args->{port} ? $args->{port} : 7496);
        $self->set(\@client_ID, exists $args->{client_ID} ? $args->{client_ID} 
                                                          : $$) ;
        my $api = Finance::InteractiveBrokers::TWS::Inline_Bridge->new($args->{callback});
        my $ib  = Finance::InteractiveBrokers::TWS::com::ib::client::EClientSocket->new($api);
        
        $self->set(\@callback, $args->{callback});
        $self->set(\@api, $api);
        $self->set(\@EClientSocket,  $ib);
    }
}

sub new_ComboLeg {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::ComboLeg->new(@_);
}

sub new_ContractDetails {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::ContractDetails->new(@_);
}

sub new_Contract {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::Contract->new(@_);
}

sub new_EClientErrors {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::EClientErrors->new(@_);
}

sub new_ExecutionFilter {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::ExecutionFilter->new(@_);
}

sub new_Execution {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::Execution->new(@_);
}

sub new_Order {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::Order->new(@_);
}

sub new_ScannerSubscription {
    my $self = shift;
    return Finance::InteractiveBrokers::TWS::com::ib::client::ScannerSubscription->new(@_);
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
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void openOrder(int orderId, Contract contract, Order order) 
    {
        try {
            perlobj.InvokeMethod("openOrder", new Object [] {
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void error(String str) 
    {
        try {
            perlobj.InvokeMethod("error", new Object [] {
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
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void bondContractDetails(ContractDetails contractDetails) 
    {
        try {
            perlobj.InvokeMethod("bondContractDetails", new Object [] {
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void execDetails(int orderId, Contract contract, 
                            Execution execution) {
    
        try {
            perlobj.InvokeMethod("execDetails", new Object [] {
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
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void managedAccounts(String accountsList) 
    {
        try {
            perlobj.InvokeMethod("managedAccounts", new Object [] {
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
    
	public void receiveFA(int faDataType, String xml) 
    {
        try {
            perlobj.InvokeMethod("receiveFA", new Object [] {
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
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
	
    public void scannerParameters(String xml) {
        try {
            perlobj.InvokeMethod("scannerParameters", new Object [] {
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
            });
        }
        catch (InlineJavaPerlException pe){ }
        catch (InlineJavaException pe) { pe.printStackTrace() ;}
    }
}

__END__

=head1 NAME

Lets you talk to Interactivebrokers Trader's Workstation using Perl.

Finance::InteractiveBrokers::TWS is a wrapper around InteractiveBroker's Trader's Workstation (TWS) Java interface, that lets one interact with the TWS using Perl, via the vendor supplied API.

=head1 VERSION

This document describes Finance::InteractiveBrokers::TWS version 0.0.1

=head1 SYNOPSIS

 package Callback;
 use strict;
 
 sub new {
     bless {}, shift;
 }
 
 sub tickPrice {
     my $self = shift;
     print "tickPrice called with: ", join(" ", @_), "\n";
 }
 
 sub tickSize {
     my $self = shift;
     print "tickSize called with: ", join(" ", @_), "\n";
 }
 
 sub nextValidId {
     my $self = shift;
     print "nextValidId called with: ", join(" ", @_), "\n";
 }
 
 sub error {
     my $self = shift;
     print "error: ", join(" ", @_), "\n";
 }
 
 package main;
 
 use strict;
 use Finance::InteractiveBrokers::TWS;
 
 my $callback = Callback->new();
 my $tws      = Finance::InteractiveBrokers::TWS->new(callback=>$callback);
 my $ib       = $tws->get_EClientSocket();
 my $api      = $tws->get_api();
 
 ####                        Host         Port    Client_ID
 ####                        ----         ----    ---------
 my @tws_GUI_location = qw/  127.0.0.1    7496       15     /;
 
 $ib->eConnect(@tws_GUI_location);
 $api->OpenCallbackStream() ;
 
 my $flag = 1;
 
 my $contract = $tws->new_Contract();
 $contract->{m_symbol} = 'YHOO';
 $contract->{m_secType} = 'STK';
 $contract->{m_exchange} = 'SMART';
 
 while ((my $got_data = $api->WaitForCallback(.01)) > -1) {
 
     if ($got_data) {
         $api->ProcessNextCallback() ;
     }
     else {
         if ($flag) {
             $flag=0;
             my $contract_id = 50;
             $ib->reqMktData($contract_id, $contract);
         }
     }
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

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

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
