#!/usr/bin/perl -w 

use strict; 
use lib "/opt/rt4/lib"; 
use RT; 
use Getopt::Long qw(GetOptions);
#use RT::Interface::CLI qw( CleanEnv ); 

#CleanEnv(); 
RT::LoadConfig(); 
RT::Init(); 

my $target_group; 
my $member_group; 




sub usage { 
  print "\n"; 
  print "\nUsage :$0 --target TargetGroup --member MemberGroup\n";
  print "\n"
} 

GetOptions(
  'target=s'      => \$target_group,
  'member=s'     => \$member_group, 
) or
  usage();

if ( 
     not defined $target_group or
     not defined $member_group    
     ) { 

       usage();
       exit;
   }


my $TargetGroup = RT::Group->new ( $RT::SystemUser ); 
my $MemberGroup = RT::Group->new ( $RT::SystemUser );  
my $Result;

$Result = $TargetGroup->LoadUserDefinedGroup( $target_group );
print "TargetGroup Load Result : \n $Result \n";
$Result = $MemberGroup->LoadUserDefinedGroup( $member_group );
print "MemberGroup Load Result : \n $Result \n";
 
$Result = $TargetGroup->AddMember( $MemberGroup->PrincipalObj->Id );  
print "AddMember Result : \n $Result \n"; 



