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
my $email; 
my $password; 
my $realname; 
my $mobile; 


my $User = RT::User->new ( $RT::SystemUser ); 


sub usage { 
  print "\n";
  print "Usage :$0 --name Username  --email EmailID --password password --realname RealName --mobile Mobile";
  print "\n";
} 

GetOptions(
  'name=s'      => \$username,
  'email=s'     => \$email, 
  'password=s'  => \$password,
  'realname=s'  => \$realname, 
  'mobile=s'    => \$mobile
) or
  usage();

if ( 
     not defined $username or
     not defined $email    or 
     not defined $password or 
     not defined $realname or
     not defined $mobile    ) { 

       usage();
       exit;
   }

 
my $Result =  $User->Create( Name => $username , 
               EmailAddress => $email,
               Password => $password,
               RealName => $realname,
               MobilePhone => $mobile,
               Disabled => 0, 
               Privileged => 1 ); 


print "\n$Result\n";
