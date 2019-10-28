#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use File::Spec;

my $lagdaFile = $ARGV[0];
die "File $lagdaFile does not exist!" if ! -e $lagdaFile;
my $htmlFile = $lagdaFile =~ s/\.lagda\.md$/\.html/r;
print "HTML file: $htmlFile\n";
my $file = $lagdaFile =~ s/\.lagda//r;
print "Markdown file: $file\n";

print `agda --html --html-highlight=code $lagdaFile`;
print `cp html/$file .`;
`rm -rf html`;
die "File $file does not seem to show up!" if ! -e $file;

# rename($file, "$file\.bak");
open(IN,  "<$file") or die $!;
open(OUT, ">LAgda/$file") or die $!;

while (<IN>) {
		s/$htmlFile//g;
		s/href=\"(Cubical|Agda)/href=\"\/lagda\/$1/g;
		print OUT $_;
}

close(IN);
close(OUT);
`rm $file`;
# `rm $file.bak`;
