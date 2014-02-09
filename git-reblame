#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $dir = shift;

die "Please provide a directory name to check\n"
    unless $dir;

chdir $dir
    or die "Failed to enter the specified directory '$dir': $!\n";

if ( ! open(GIT_LS,'-|','git ls-files') ) {
    die "Failed to process 'git ls-files': $!\n";
}
my %stats;
while (my $file = <GIT_LS>) {
    chomp $file;
    if ( ! open(GIT_LOG,'-|',"git log --numstat $file") ) {
        die "Failed to process 'git log --numstat $file': $!\n";
    }
    my $author;
    while (my $log_line = <GIT_LOG>) {
        if ( $log_line =~ m{^Author:\s*([^<]*?)\s*<([^>]*)>} ) {
            $author = lc($1);
        }
        elsif ( $log_line =~ m{^(\d+)\s+(\d+)\s+(.*)} ) {
            my $added = $1;
            my $removed = $2;
            my $file = $3;
            $stats{total}{by_author}{$author}{added}        += $added;
            $stats{total}{by_author}{$author}{removed}      += $removed;
            $stats{total}{by_author}{total}{added}          += $added;
            $stats{total}{by_author}{total}{removed}        += $removed;

            $stats{total}{by_file}{$file}{$author}{added}   += $added;
            $stats{total}{by_file}{$file}{$author}{removed} += $removed;
            $stats{total}{by_file}{$file}{total}{added}     += $added;
            $stats{total}{by_file}{$file}{total}{removed}   += $removed;
        }
    }
    close GIT_LOG;

    if ( ! open(GIT_BLAME,'-|',"git blame -w $file") ) {
        die "Failed to process 'git blame -w $file': $!\n";
    }
    while (my $log_line = <GIT_BLAME>) {
        if ( $log_line =~ m{\((.*?)\s+\d{4}} ) {
            my $author = $1;
            $stats{final}{by_author}{$author}     ++;
            $stats{final}{by_file}{$file}{$author}++;

            $stats{final}{by_author}{total}       ++;
            $stats{final}{by_file}{$file}{total}  ++;
            $stats{final}{by_file}{$file}{total}  ++;
        }
    }
    close GIT_BLAME;
}
close GIT_LS;

print "Total lines committed by author by file\n";
printf "%25s %25s %8s %8s %9s\n",'file','author','added','removed','pct add';
foreach my $file (sort keys %{$stats{total}{by_file}}) {
    printf "%25s %4.0f%%\n",$file
            ,100*$stats{total}{by_file}{$file}{total}{added}/$stats{total}{by_author}{total}{added};
    foreach my $author (sort keys %{$stats{total}{by_file}{$file}}) {
        next if $author eq 'total';
        printf "%25s %25s %8d %8d %8.0f%%\n",'', $author,@{$stats{total}{by_file}{$file}{$author}}{qw{added removed}}
            ,100*$stats{total}{by_file}{$file}{$author}{added}/$stats{total}{by_file}{$file}{total}{added};
    }
}
print "\n";

print "Total lines in the final project by author by file\n";
printf "%25s %25s %8s %9s %9s\n",'file','author','final','percent', '% of all';
foreach my $file (sort keys %{$stats{final}{by_file}}) {
    printf "%25s %4.0f%%\n",$file
            ,100*$stats{final}{by_file}{$file}{total}/$stats{final}{by_author}{total};
    foreach my $author (sort keys %{$stats{final}{by_file}{$file}}) {
        next if $author eq 'total';
        printf "%25s %25s %8d %8.0f%% %8.0f%%\n",'', $author,$stats{final}{by_file}{$file}{$author}
            ,100*$stats{final}{by_file}{$file}{$author}/$stats{final}{by_file}{$file}{total}
            ,100*$stats{final}{by_file}{$file}{$author}/$stats{final}{by_author}{total}
        ;
    }
}
print "\n";


print "Total lines committed by author\n";
printf "%25s %8s %8s %9s\n",'author','added','removed','pct add';
foreach my $author (sort keys %{$stats{total}{by_author}}) {
    next if $author eq 'total';
    printf "%25s %8d %8d %8.0f%%\n",$author,@{$stats{total}{by_author}{$author}}{qw{added removed}}
        ,100*$stats{total}{by_author}{$author}{added}/$stats{total}{by_author}{total}{added};
};
print "\n";


print "Total lines in the final project by author\n";
printf "%25s %8s %9s\n",'author','final','percent';
foreach my $author (sort keys %{$stats{final}{by_author}}) {
    printf "%25s %8d %8.0f%%\n",$author,$stats{final}{by_author}{$author}
        ,100*$stats{final}{by_author}{$author}/$stats{final}{by_author}{total};
}
