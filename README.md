# SyncPager (1.0)
Alerts the Syncronet system operator that someone wants to talk to them.

Official support sites: [Official Github Repo](https://github.com/fstltna/SyncPager) - [Official Forum](https://synchronetbbs.org/index.php/forum/syncpager) or mail to marisag@synchronetbbs.org
![Synchronet Logo](https://SynchronetBBS.org/SynchronetLogo.png)

[![Visit our IRC channel](https://kiwiirc.com/buttons/irc.synchro.net/SynchronetFans.png)](https://kiwiirc.com/client/irc.synchro.net/?nick=guest|?#SynchronetFans)

***

1. Make sure the Audio::MPEG requirements are met:

	-- On Debian, Ubuntu, Mint
	sudo apt-get install libmp3lame-dev

        -- On Fedora, CentOS, and RHEL
        sudo yum --enablerepo=rpmfusion-free-updates install lame-devel 

2. Use CPAN to install the following Perl modules:

        Email::Simple
        Email::Simple::Creator
        Email::Sender::Simple qw(sendmail)
        LWP::Simple
        Audio::MPEG

3. Copy **syncnotify** to **/sbbs/exec** - follow instructions on adding main script in scfg when sysop is being paged

        scfg->Chat Features->External Sysop Chat Pagers
        
        Command Line "/sbbs/exec/syncnotify %# %a"
        Intercept: no
        Native: Yes
        Shell: Yes

4. Copy **clearpager** to **/sbbs/exec** - follow instructions about adding this as logout script in scfg

        scfg->External Programs->Fixed Events->Logout Event
                
        Command Line "clearpager %#"

5. Copy **ackpager** to **/sbbs/exec** - follow instructions on adding sysop command

        scfg->External Programs->Online Program Sections->Main->Main Program Section
                
        Command Line "clearpager %#"
        
        Make sure you set the access level to 90

---
Use XRCed to edit the .xrc file
