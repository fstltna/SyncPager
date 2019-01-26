# SyncPager (1.1)
Alerts the Syncronet system operator that someone wants to talk to them.

Official support sites: [Official Github Repo](https://github.com/fstltna/SyncPager) - [Official Forum](https://synchronetbbs.org/index.php/forum/syncpager) or mail to marisag@synchronetbbs.org
![Synchronet Logo](https://SynchronetBBS.org/SynchronetLogo.png)

[![Visit our IRC channel](https://kiwiirc.com/buttons/irc.synchro.net/SynchronetFans.png)](https://kiwiirc.com/client/irc.synchro.net/?nick=guest|?#SynchronetFans)

***

1. Install audacious:

	apt-get install audacious

1. Use CPAN to install the following Perl modules:

        Email::Simple
        Email::Simple::Creator
        Email::Sender::Simple
        LWP::Simple
        Wx

2. On the BBS server copy **syncnotify** to **/sbbs/exec** - follow instructions on adding main script in scfg when sysop is being paged

        scfg->Chat Features->External Sysop Chat Pagers
        
        Command Line "/sbbs/exec/syncnotify %# %a"
        Intercept: no
        Native: Yes
        Shell: Yes

3. On the BBS server copy **clearpager** to **/sbbs/exec** - follow instructions about adding this as logout script in scfg

        scfg->External Programs->Fixed Events->Logout Event
                
        Command Line "clearpager %#"

4. On the BBS server copy **ackpager** to **/sbbs/exec** - follow instructions on adding sysop command

        scfg->External Programs->Online Program Sections->Main->Main Program Section
                
        Command Line "/sbbs/exec/ackpager"
        
        Make sure you set the access level to 90

---
Use XRCed to edit the .xrc file
