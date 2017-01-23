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
my $email; 
my $password; 
my $realname; 
my $mobile; 


my $User = RT::User->new ( $RT::SystemUser ); 


sub usage { 
  print "\n"; 
  print "\nUsage :$0 --name Username --group GroupName --email EmailID --password password --realname RealName --mobile Mobile\n";
  print "\nNote : Passwords should be atleast 5 chars long\n";
  print "\n"
} 

GetOptions(
  'name=s'      => \$username,
  'group=s'     => \$group, 
  'email=s'     => \$email, 
  'password=s'  => \$password,
  'realname=s'  => \$realname, 
  'mobile=s'    => \$mobile
) or
  usage();

if ( 
     not defined $username or
     not defined $group    or 
     not defined $email    or 
     not defined $password or 
     not defined $realname or
     not defined $mobile    ) { 

       usage();
       exit;
   }

 
my $Result = $User->Create( Name => $username , 
               EmailAddress => $email,
               Password => $password,
               RealName => $realname,
               MobilePhone => $mobile,
               Disabled => 0, 
               Privileged => 1 ); 

print $Result; 
my $Group = RT::Group->new ( $RT::SystemUser ); 
$Group->LoadUserDefinedGroup( $group ); 
$Group->AddMember( $User->PrincipalObj->Id ); 


