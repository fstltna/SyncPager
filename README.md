# SyncPager (1.2)
Alerts the Syncronet system operator that someone wants to talk to them.

Official support sites: [Official Github Repo](https://github.com/fstltna/SyncPager) - [Official Forum](https://synchronetbbs.org/index.php/forum/syncpager) or mail to marisag@synchronetbbs.org
![Synchronet Logo](https://SynchronetBBS.org/SynchronetLogo.png)

[![Visit our IRC channel](https://kiwiirc.com/buttons/irc.synchro.net/SynchronetFans.png)](https://kiwiirc.com/client/irc.synchro.net/?nick=guest|?#SynchronetFans)

***

1. Install audacious on the client/local-side:

	apt-get install audacious

2. Use CPAN to install the following Perl modules (on both client & server):

        cpan -i Email::Simple
        cpan -i Email::Simple::Creator
        cpan -i Email::Sender::Simple
        cpan -i LWP::Simple

3. On the BBS server copy **syncnotify** to **/sbbs/exec** - follow instructions on adding main script in scfg when sysop is being paged

        scfg->Chat Features->External Sysop Chat Pagers
        
        Command Line "/sbbs/exec/syncnotify %# %a"
        Intercept: no
        Native: Yes
        Shell: Yes

4. On the BBS server copy **clearpager** to **/sbbs/exec** - follow instructions about adding this as logout script in scfg

        scfg->External Programs->Fixed Events->Logout Event
                
        Command Line "clearpager %#"

5. On the BBS server copy **ackpager** to **/sbbs/exec** - follow instructions on adding sysop command

        scfg->External Programs->Online Program Sections->Main->Main Program Section
                
        Command Line "/sbbs/exec/ackpager"
        
        Make sure you set the access level to 90



***

Copy the **config.ini.example** file to **config.ini** file on your local computer. Then edit it for your settings. Most important is the **CheckURL** entry that should be like the default but for your BBS server.

Then all you need to do is run the SyncPager script and let it run and you will be notified when someone tries to chat with you...

I suggest you do it like this:

crontab -e

add this line to the bottom:

@reboot ~/Documents/SyncPager/startpager start

Finally start it up like this: **cd ~/Documents/SyncPager;~/Documents/SyncPager/startpager start**

