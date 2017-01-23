#!/usr/bin/perl -w 

use strict; 
use lib "/opt/rt4/lib"; 
use RT; 
use Getopt::Long qw(GetOptions);
#use RT::Interface::CLI qw( CleanEnv ); 

#CleanEnv(); 
RT::LoadConfig(); 
RT::Init(); 

my $username; 
my $group; 




sub usage { 
  print "\n"; 
  print "\nUsage :$0 --name Username  \n";
  print "\n"
} 

GetOptions(
  'name=s'      => \$username,
) or
  usage();

if ( 
     not defined $username 
     ) { 

       usage();
       exit;
   }

 

my $User = RT::User->new ( $RT::SystemUser ); 
my $Result = $User->Load($username);
print "Load User Result : \n $Result \n"; 


$Result = $User->SetPassword( "password" ); 
print "Set Password  Result : \n $Result \n";


