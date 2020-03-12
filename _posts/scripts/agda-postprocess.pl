#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use File::Spec;

print `mkdir -p lagda`;
print `mkdir -p ../assets/lagda`;

my $lagdaFile = $ARGV[0];
die "File $lagdaFile does not exist!" if ! -e $lagdaFile;
my $htmlFile = $lagdaFile =~ s/\.lagda\.md$/\.html/r;
print "HTML file: $htmlFile\n";
my $file = $lagdaFile =~ s/\.lagda//r;
print "Markdown file: $file\n";

print `agda --html --html-highlight=code $lagdaFile`;
print `cp html/$file .`;

foreach my $fixture (split /[ \t\n]+/, `ls html/*.html`) {
	my $outFileName = $fixture =~ s/html\/(.+).html/$1/r;
	my $outFile = "../assets/lagda/$outFileName.md";
	print `rm $outFile` if -e $outFile;
	open(OUT, ">$outFile") or die $!;
	print OUT "---
layout: page
permalink: /lagda/$outFileName.html
inline_latex: true
agda: true
---
<body>
{% raw %}
<pre class=\"Agda\">
";
	print OUT `cat $fixture`;
	print OUT "
</pre>
{% endraw %}
</body>";
	close(OUT);
}

print `rm -rf html`;
die "File $file does not seem to show up!" if ! -e $file;

# rename($file, "$file\.bak");
open(IN,  "<$file") or die $!;
open(OUT, ">lagda/$file") or die $!;

while (<IN>) {
	s/$htmlFile//g;
	s/href=\"(Cubical|Agda)/href=\"\/lagda\/$1/g;
	print OUT $_;
}

close(IN);
close(OUT);
`rm $file`;
# `rm $file.bak`;
