#!/usr/bin/perl -w

# Skript zum einfacheren Empfang von Internet-Livestreams diverser Radiosender
use strict;
use warnings;
use FindBin;

my %mpv_options = ("mp3" => "--volume-max=200 --cache-secs=20 --display-tags-clr", "m3u" => "--volume-max=200 --cache-secs=20 --display-tags-clr", "aac" => "--volume-max=200 --cache-secs=20 --display-tags-clr", "else" => "--volume-max=200 --cache-secs=20 --display-tags-clr");
my %mpv = ("player" => "mpv", "options" => \%mpv_options);
my %player = ("mpv" => \%mpv);

if ($#ARGV < 0){
	print_exit();
}

my $sender = "$ARGV[0]";
my %senderliste;
my @all_sender;
my @all_sender_sorted;
my @linkliste;
if ($sender eq "list"){
	%senderliste = get_senderliste();
	@all_sender = keys(%senderliste);
	@all_sender_sorted = sort { $a cmp $b } @all_sender;
	print join(" ",@all_sender_sorted);
	print "\n";
	exit;
} elsif ($sender eq "query") {
	%senderliste = get_senderliste();
	@all_sender = keys(%senderliste);
	@all_sender_sorted = sort { $a cmp $b } @all_sender;
	print join("\n",@all_sender_sorted);
	print "\n";
	exit;
} elsif ($sender eq "fulllist") {
	%senderliste = get_senderliste();
	@all_sender = keys(%senderliste);
	@all_sender_sorted = sort { $a cmp $b } @all_sender;
	foreach my $nr (0..$#all_sender_sorted) {
		my $cur_sender = $all_sender_sorted[$nr];
		print "$cur_sender => $senderliste{$cur_sender}\n";
	}
	exit;
} elsif ($sender eq "number") {
        @linkliste = get_urls();
        print scalar @linkliste;
        print "\n";
        exit;
}
switch_sender($sender);


sub print_exit {
	print "Gebrauch: livestream.pl sender/list/query\n";
	exit;
}


sub switch_sender {
	my $str = shift;
	my %senderliste = get_senderliste();
	if(exists $senderliste{$str}){
		my $url = $senderliste{$str};
		my $modus = get_modus($url);
		my $cur_player = $player{mpv}{player};
		my $cur_options = $player{mpv}{options}{$modus};
		system("$cur_player $cur_options $url");
	} else {
		print_exit();
	}
}


sub get_senderliste {
	my %res;
	my $listfile = "$FindBin::RealBin/livestream.list";
	open(LIST, $listfile) || die "Kann Senderliste nicht öffnen!\n";
	while (my $line = <LIST>){
		chomp($line);
		if($line !~ /^#/) {
			my @linearray = split(/[\t ]+/,$line);
			foreach my $nr (1..$#linearray) {
				$res{$linearray[$nr]} = $linearray[0];
			}
		}
	}
	close(LIST);
	return %res;
}

sub get_urls {
        my @res;
        my $listfile = "$FindBin::RealBin/livestream.list";
        open(LIST,$listfile) || die "Kann Senderliste nicht öffnen!\n";
        while (my $line = <LIST>){
                chomp($line);
                if($line !~ /^#/) {
                        my @linearray = split(/[\t ]+/,$line);
                        push(@res,$linearray[0]);
                }
        }
        close(LIST);
        return @res;
}


sub get_modus {
	my $str = shift;
	my $res;
	if ($str =~ /.*(mp3|m3u|aac)/) {
		$str =~ /.*(mp3|m3u|aac)/;
		$res = $1;
	} else {
		$res = "else";
	}
	return $res;
}
