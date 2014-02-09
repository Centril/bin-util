#!/usr/bin/env perl

my %file;
my $contributor = q();

while (<>) {
    chomp;
    if (/^\S/) {
        $contributor = $_;
    }
    elsif (/^\s*(.*?)\s*\|\s*\d+\s*[+-]+/) {
        $file{$1}{$contributor} = 1;
    }
}

for my $filename (sort keys %file) {
    print "$filename:\n";
    for my $contributor (sort keys %{$file{$filename}}) {
        print "  * $contributor\n";
    }
}