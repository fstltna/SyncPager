package WxSimple; use base qw(Wx::App Exporter);
    use strict;
    use Exporter;

    our $VERSION     = 0.10;
    our @EXPORT_OK   = qw(StartApp FindWindowByXid MsgBox $frame $xr
    	$xrc $frmID $sbar %menu $OpenFile $SaveFile $CloseWin $icon);
    use Wx;
    use Carp;

    our $frame;
    our $xr;
    our $xrc   = 'res/res.xrc';	# location of resource file
    our $frmID = 'Frame';	# XML ID of the main frame
    our $sbar  = 0;		# number of status bar sections
    our %menu  =		# menu handlers,
    				# you can replace them with your own
    				# or add your own menu items
    (	wxID_OPEN   => \&Open,	#    these are four readymade handlers
    	wxID_SAVE   => \&Save,	#    that just get a file-name for reading
    	wxID_SAVEAS => \&SaveAs,#    or writing
    	wxID_EXIT   => \&Exit,	#    and quit just exits.
    );
    our $OpenFile = \&OpenFile; # A routine to read data from a file
    our $SaveFile = \&SaveFile; # A routine to write data to a file
    our $CloseWin = \&CloseWin;	# this is not a menu option
    				# it is the routine called before the end
    				# it needs to Destroy() all top level dialogs
    our $icon  = Wx::GetWxPerlIcon();
    my  $file;			# the name of the file used in Open/Save

    sub StartApp
    {   WxSimple->new()->MainLoop();
    }

    sub OnInit
    {	my $app = shift;
    	#
    	# Load XML Resources
    	#
        use Wx::XRC;
        $xr = Wx::XmlResource->new();
        $xr->InitAllHandlers();
    	croak "No Resource file $xrc" unless -e $xrc;	
        $xr->Load( $xrc );
	#
	# Load the main frame from resources
	#
	$frame = 'Wx::Frame'->new;
	croak "No Frame named $frmID in $xrc" unless
	    $xr->LoadFrame($frame, undef, $frmID);
        if ($sbar)
        {   $frame->CreateStatusBar( $sbar );
            $frame->SetStatusWidths(-1,200);
        }
        $frame->SetIcon( $icon );
        #
        # Set event handlers
        #
    	use Wx::Event qw(EVT_MENU EVT_CLOSE);
    	while (my ($xrcid, $handler) = each %menu)
        {   my $id = Wx::XmlResource::GetXRCID($xrcid, -2);
	    if ($id == -2)
	    {   carp "No MenuItem named $xrcid";
	        next;
	    }
            EVT_MENU( $frame, $id, $handler );
	}
        EVT_CLOSE( $frame, $CloseWin );
	#
	# Show the window
	#
        $app->SetTopWindow( $frame );
        $frame -> Show(1);
        1;
    }

    sub FindWindowByXid
    {   my $id = Wx::XmlResource::GetXRCID($_[0], -2);
        return undef if $id == -2;
        my $win = Wx::Window::FindWindowById($id, $frame);
        return wantarray ? ($win, $id) : $win;
    }

    sub MsgBox
    {   use Wx qw (wxOK wxICON_EXCLAMATION);
        my @args = @_;
        $args[1] = 'Message' unless defined $args[1];
        $args[2] = wxOK | wxICON_EXCLAMATION unless defined $args[2];
    	my $md = Wx::MessageDialog->new($frame, @args);
        $md->ShowModal();
    }

    sub Open
    {   use Wx qw (wxID_CANCEL wxFD_FILE_MUST_EXIST);
        my $dlg = Wx::FileDialog->new($frame,
          'Select one or more Files', '', '',
          'Text Files|*.txt|All Files|*.*',
          wxFD_FILE_MUST_EXIST);
        if ($dlg->ShowModal() == wxID_CANCEL) { return }
        $file = $dlg->GetPath();
        $frame->SetStatusText("Opening...$file", 0);
        my $busy = Wx::BusyCursor->new();
        $OpenFile->($file);
        $frame->SetStatusText("Opening...$file...Done", 0);
    }
    
    sub Save
    {   $frame->SetStatusText("Saving...$file", 0);
        my $busy = Wx::BusyCursor->new();
	$SaveFile->($file);
        $frame->SetStatusText("Saving...$file...Done", 0);
    }
    
    sub SaveAs
    {   use Wx qw (wxID_CANCEL wxFD_OVERWRITE_PROMPT wxFD_SAVE);
        my $dlg = Wx::FileDialog->new($frame,
          'Select one or more Files', '', '',
          'Text Files|*.txt|All Files|*.*',
          wxFD_OVERWRITE_PROMPT | wxFD_SAVE);
        if ($dlg->ShowModal() == wxID_CANCEL) { return }
        $file = $dlg->GetPath();
        Save();
    }
    
    sub OpenFile
    {   MsgBox "Add Code to Open $file";
    }
    
    sub SaveFile
    {   MsgBox "Add Code to Save $file";
    }
    
    sub Exit
    {   CloseWin();
    }
    #
    # Close is not called by the menu, but is called to close all windows
    # If there are any toplevel dialogs, close them here, otherwise the
    # program will not exit.
    #
    sub CloseWin
    {   $frame->Destroy();
    }

1;
__END__


=head1 NAME

WxSimple: A package to make throwaway WxPerl programs using C<XRC>

=head1 SYNOPSIS

    use WxSimple;
    
    # one-liner (use all default options)
    WxSimple::StartApp();
       ...
    
    # with modified defaults
    use WxSimple qw(qw(StartApp FindWindowByXid MsgBox $frame $xr
    	$xrc $frmID $sbar %menu $OpenFile $SaveFile $CloseWin $icon);
    $xrc   = 'res/res.xrc';
    $frmID = 'MainFrame';
    $sbar  = 1;
    $menu{OpenFile} = \&::Open;
    $menu{Options}  = \&::OnOptions;
       ...
    my $app = WxSimple->new();
       ...
    $app->MainLoop();

=head1 DESCRIPTION

    GUI programming always looks rather bulky. This package makes the
    code much smaller, making it easy to write throwaway, one-time use
    WxPerl programs. The windows, menus, toolbars are all defined using
    C<XRC>.
    
    To simplify menu event handling, just define the hash C<%WxSimple::menu>
    with keys that are the XML ID's for each menuitem, and values that are
    references to the handlers for that menuitem.

    The menu events for C<wxID_OPEN>, C<wxID_SAVE>, C<wxID_SAVEAS> and 
    C<wxID_EXIT> have default definitions. The first three events get a
    file name (using a file dialog for Open and Save As) and then call 
    the coderef pointed to by $FileOpen, or $FileSave, with that file name 
    as the argument. Quit will close the window and exit. You can override 
    any of these definitions, by redefining C<%WxSimple::menu>.

    The XML ID for the main frame is given in C<$WxSimple::frmID>.

    The number of sections in the status bar is given by C<$WxSimple::sbar>.
    If this is C<0>, no status bar is created.

    The name of the XML resource file generated by XRC is set in
    C<$WxSimple::xrc>.
    
    The variables C<$WxSimple::frame> and C<$WxSimple::xr> contain the main
    frame and the XML resource, once C<new> has been called
    
=head2 Structure

    The main program usually looks like a C<use WxSimple> statement, followed
    by setting a few parameters. Then the C<%WxSimple::menu> hash usually has
    to be defined, providing a handler for every menu event.
    
    This is followed by creating a C<$app> using a call to C<WxSimple->new()>.
    At this point the variables C<$WxSimple::frame> and C<$WxSimple::xr> are 
    created. If further things need to be added to the frame, this is the time
    to do that.
    
    Finally a call to C<MainLoop()> starts the window loop.

