#!/usr/bin/perl -w  

# Calling the script 
# 

use strict; 
use lib "/opt/rt4/lib"; 
use RT; 
use Getopt::Long qw(GetOptions);
#use RT::Interface::CLI qw( CleanEnv ); 

my $group_name ;
my $group_desc ; 

GetOptions(
  'name=s' => \$group_name,
) or die "Usage :$0 --name GroupName\n" ;

if ( not defined $group_name ) { 
   print "Usage :$0 --name GroupName\n";
   exit;
} 


#CleanEnv(); 
RT::LoadConfig(); 
RT::Init(); 

my $Group = RT::Group->new ( $RT::SystemUser );
my $Result = $Group->LoadUserDefinedGroup($group_name);  
print "\n Load Group Result : \n $Result \n";

my $Desc = $Group->SelfDescription(); 
print "\n\nGroup : $Desc\n\n"; ;

$Result = $Group->Delete(); 
print "\n Delete Group Result : \n $Result \n";




            





