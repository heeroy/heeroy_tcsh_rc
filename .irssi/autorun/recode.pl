use strict;
use warnings;
use Text::Iconv;
use vars qw($VERSION %IRSSI);

$VERSION = "0.2";

%IRSSI = (
    authors     => 'Marcin Kowalczyk, changes by Timo Sirainen, Taneli Kaivola, Kuang-che Wu and Geert Hauwawerts',
    name        => 'recode',
    description => 'Charset translator - defaults to UTF-8 with fallback to ISO-8859-15',
    license     => 'GPLv2'
);

our %workers_pre  = ();
our %workers_post = ();
our %locks        = ();

sub wrapper
{
    my $signal = Irssi::signal_get_emitted();
    return if $locks{$signal};
    &{$workers_pre{$signal}} or return;
    $locks{$signal} = 1;
    Irssi::signal_emit($signal, @_);
    $locks{$signal} = 0;
    &{$workers_post{$signal}};
    Irssi::signal_stop();
}

sub signal_add_good
{
    my ($signal, $worker_pre, $worker_post) = @_;
    $workers_pre{$signal} = $worker_pre;
    $workers_post{$signal} = $worker_post || sub {};
    Irssi::signal_add($signal, \&wrapper);
}

########

our $iconv_in_fallback = Text::Iconv->new("iso-8859-15//translit", "utf-8");
our $iconv_default_in = Text::Iconv->new("utf-8", "utf-8");
our $iconv_default_out = Text::Iconv->new("utf-8", "iso-8859-15//translit");

sub convert
{
    my ($iconv, $s_in) = @_;
    local $SIG{'__WARN__'} = sub {};
    my $s_out = $iconv->convert($s_in);
    if (!defined $s_out) {
        $s_out = $iconv_in_fallback->convert($s_in);
        defined $s_out or $s_out = "$s_in \cc7,1[conversion error]\co";
    }
    return $s_out;
}

our $iconv_utf8 = Text::Iconv->new("utf-8", "utf-8");

########

our %conversions_in =
(
#    '#irssi.fi' => $iconv_utf8,
#    '#irssi' => $iconv_utf8,
);

our %conversions_out =
(
#    '#irssi.fi' => $iconv_utf8,
#    '#irssi' => $iconv_utf8,
);

########

our $last_own;

sub sig_message_own
{
    if (defined $last_own) {$_[1] = $last_own; return 1}
    return 0;
}

signal_add_good("message own_public", \&sig_message_own);
signal_add_good("message own_private", \&sig_message_own);
signal_add_good("message irc own_action", \&sig_message_own);
signal_add_good("message dcc own", \&sig_message_own);
signal_add_good("message dcc own_action", \&sig_message_own);

sub get_converter_in
{
    my $converter = $conversions_in{lc $_[0]};
    $converter = $iconv_default_in if (!$converter);
    return $converter;
}

sub get_converter_out
{
    my $converter = $conversions_out{lc $_[0]};
    $converter = $iconv_default_out if (!$converter);
    return $converter;
}

sub sig_command_msg
{
    $_[0] =~ /^((?:-\S+ )*)([^ ]+) (.*)$/ or return 0;
    my ($opt, $who, $msg) = ($1, $2, $3);
    (my $who1 = $who) =~ s/^=//;

    my $converter;
    if ($msg =~ /^([\S]+): / && Irssi::settings_get_bool("channelthingy"))
    {
        # 'nick: ' in channel.
        $converter = $conversions_out{lc $1};
    }

    $converter = get_converter_out($who1) if (!$converter);
    if ($converter)
    {
        $last_own = $msg;
        $msg = convert($converter, $msg);
        $_[0] = "$opt$who $msg";
        return 1;
    }
    return 0;
}

sub undef_last_own {undef $last_own}
signal_add_good("command msg", \&sig_command_msg, \&undef_last_own);

sub sig_command_me
{
    my $converter = get_converter_out($_[2]->{name});
    if ($converter)
    {
        $last_own = $_[0];
        $_[0] = convert($converter, $_[0]);
        return 1;
    }
    return 0;
}
signal_add_good("command me", \&sig_command_me, \&undef_last_own);

sub sig_command_action
{
    $_[0] =~ /^([^ ]+) (.*)$/ or return 0;
    my ($who, $msg) = ($1, $2, $3);
    (my $who1 = $who) =~ s/^=//;
    my $converter = get_converter_out($who1);
    if ($converter)
    {
        $last_own = $msg;
        $msg = convert($converter, $msg);
        $_[0] = "$who $msg";
        return 1;
    }
    return 0;
}
signal_add_good("command action", \&sig_command_action, \&undef_last_own);

sub sig_message_public
{
    # first check for target
    my $converter = get_converter_in($_[4]);
    # if not found, use the origin nick
    $converter = $converter || get_converter_in($_[2]);
    if ($converter) {$_[1] = convert($converter, $_[1]); return 1}
    return 0;
}
signal_add_good("message public", \&sig_message_public);

sub sig_message_private
{
    my $converter = get_converter_in($_[2]);
    if ($converter) {$_[1] = convert($converter, $_[1]); return 1}
    return 0;
}
signal_add_good("message private", \&sig_message_private);
signal_add_good("message irc action", \&sig_message_private);

sub sig_message_dcc
{
    my $converter = get_converter_in($_[0]->{nick});
    if ($converter) {$_[1] = convert($converter, $_[1]); return 1}
    return 0;
}
signal_add_good("message dcc", \&sig_message_dcc);
signal_add_good("message dcc action", \&sig_message_dcc);

sub sig_event_topic {
  my ($chan,$topic)=split(" :",$_[1],2);
  my $converter = get_converter_in($chan);
  if($converter) {
    $topic = convert($converter,$topic);
    $_[1]="$chan :$topic";
    return 1;
  }
  return 0;
}
signal_add_good("event topic", \&sig_event_topic);
signal_add_good("event 332",\&sig_event_topic);

sub sig_command_topic {
  my $converter = get_converter_out($_[2]->{name});
  if($converter) { $_[0] = convert($converter,$_[0]); return 1}
  return 0;
}
signal_add_good("command topic", \&sig_command_topic);

sub sig_message_part {
  my $converter = get_converter_in($_[1]);
  if($converter) { $_[4] = convert($converter,$_[4]); return 1}
  return 0;
}
signal_add_good("message part",\&sig_message_part);

sub sig_command_part {
  my $converter = get_converter_out($_[2]->{name});
  if($converter) { $_[0] = convert($converter,$_[0]); return 1}
  return 0;
}
signal_add_good("command part",\&sig_command_part);

sub sig_message_quit {
  my $converter = get_converter_in($_[1]);
  if($converter) { $_[3] = convert($converter,$_[3]); return 1;}
  return 0;
}
signal_add_good("message quit",\&sig_message_quit);

sub sig_command_quit {
  my $converter = $iconv_default_out; #TODO: Any better ideas?
  if($converter) { $_[0] = convert($converter,$_[0]); return 1}
  return 0;
}
signal_add_good("command quit",\&sig_command_quit);

Irssi::settings_add_bool("misc", "channelthingy", 0);
