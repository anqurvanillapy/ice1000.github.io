#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

my $ls = "*[^a][^g][^d][^a].md";

print `ls $ls`;

# TODO: should improve with more fancy regexes
my $mds = `cat $ls`;

$mds =~ s/\n/ /g;
$mds =~ s/<pre[^>]*>(.*?)<\/pre>//g;
$mds =~ s/<svg[^>]*>(.*?)<\/svg>//g;
$mds =~ s/---(.*?)---//g;

my $tmp = 'wordcloud-tmp';
open(my $fh, '>', $tmp) or die "Failed to open file '$tmp', $!";
print $fh $mds;
close $fh;

my $arg = "--width 1280 --height 720 --background white --color blue";

print `cat $tmp | wordcloud_cli $arg --imagefile pic-wordcloud.png`;
print `rm $tmp`;

print "Generation done.\n";
