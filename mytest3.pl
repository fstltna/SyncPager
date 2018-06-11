#!./perl/bin/perl
use strict;
use warnings;

use WxSimple qw(FindWindowByXid MsgBox $xrc $sbar $OpenFile $frame);
#
# set up parameters
#
$xrc      = 'SyncPager.xrc';    # location of xrc file
$sbar     = 2;	                # status bar with 2 sections
$OpenFile = \&OpenFile;	        # function that opens a file
#
# create an app
#
my $app = WxSimple->new();      # create app and main frame
#
# now, find controls inside the main window
# and set up event handlers for them.
#
my ($checkbox, $id) = FindWindowByXid('CheckBox');
Wx::Event::EVT_CHECKBOX($frame, $id, \&OnCheck );

my $smalltext = FindWindowByXid('SmallText');

#
# start the main loop
#
$app->MainLoop();
#
# -------------------------------------
# here are the event handlers
# run the program. Open a file. Check the checkbox
#
sub OpenFile
{   my $file = shift;
    local $/;
    my $textbox = FindWindowByXid('Output');
    open F, '<', $file;
    $textbox->ChangeValue(<F>);
    close F;
    #MsgBox('The file is loaded in the text box');
}

sub OpenAbout
{   my $file = shift;
    local $/;
    my $textbox = FindWindowByXid('Output');
    open F, '<', "AboutText.txt";
    $textbox->ChangeValue(<F>);
    close F;
    MsgBox('The file is loaded in the text box');
}

sub OnCheck
{   my ($this, $evt) = @_;
    if ($evt->IsChecked()) { $smalltext->ChangeValue('checked'); }
    else		   { $smalltext->ChangeValue('unchecked'); }
}

