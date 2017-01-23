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
  print "\nUsage :$0 --name Username --group GroupName \n";
  print "\n"
} 

GetOptions(
  'name=s'      => \$username,
  'group=s'     => \$group, 
) or
  usage();

if ( 
     not defined $username or
     not defined $group    
     ) { 

       usage();
       exit;
   }

 

my $User = RT::User->new ( $RT::SystemUser ); 
my $Result = $User->Load($username);
print "Load User Result : \n $Result \n"; 

my $Group = RT::Group->new ( $RT::SystemUser ); 
$Result = $Group->LoadUserDefinedGroup( $group ); 
print "Load Group Result : \n $Result \n";

$Result = $Group->AddMember( $User->PrincipalObj->Id ); 
print "Add User to Group Result : \n $Result \n";


