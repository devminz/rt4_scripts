#!/usr/bin/perl -w  

# Calling the script 
# 

use strict; 
use lib "/opt/rt4/lib"; 
use RT; 
use Getopt::Long qw(GetOptions);
#use RT::Interface::CLI qw( CleanEnv ); 

my $name ;
my $desc ; 
my $tag  ; 

sub usage {
  print "\n";
  print "Usage :$0 --name QueueName --desc QueueDescription --tag SubjectTag" ;
  print "\n";
}

GetOptions(
  'name=s' => \$name,
  'desc=s' => \$desc,
  'tag=s'  => \$tag
) or usage();

if ( not defined $name or not defined $desc or not defined $tag) { 
   usage();  
   exit;
} 

#CleanEnv(); 
RT::LoadConfig(); 
RT::Init(); 

my $Queue = RT::Queue->new ( $RT::SystemUser ); 
my $Result = $Queue->Create(
   Name => $name,
   Description => $desc, 
   SubjectTag => $tag
);
print "Queue Creation Result : \n $Result \n"; 



            





