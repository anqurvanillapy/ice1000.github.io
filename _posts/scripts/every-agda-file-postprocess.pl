#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

foreach my $agdaFile (map {substr $_, 2} split /[ \t\n]+/, `ls -t ./*.lagda.md`) {
		print `perl scripts/agda-postprocess.pl $agdaFile`;
}
