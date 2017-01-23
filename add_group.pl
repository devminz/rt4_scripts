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

sub usage {
  print "\nUsage : $0 --name GroupName --desc GroupDescription\n";
}

GetOptions(
  'name=s' => \$group_name,
  'desc=s' => \$group_desc
) or usgae();

if ( not defined $group_name or  not defined $group_desc) { 
   usage(); 
   exit;
} 



#CleanEnv(); 
RT::LoadConfig(); 
RT::Init(); 

my $Group = RT::Group->new ( $RT::SystemUser ); 
my $Result = $Group->CreateUserDefinedGroup(
          Name => $group_name, 
          Description => $group_desc); 

print "\n Result : \n $Result \n" ;


            





