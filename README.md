# SyncPager (1.0)
Alerts the Syncronet system operator that someone wants to talk to them.

Official support sites: [Official Github Repo](https://github.com/fstltna/SyncPager) - [Official Forum](https://synchronetbbs.org/index.php/forum/syncpager) or mail to marisag@synchronetbbs.org
![Synchronet Logo](https://SynchronetBBS.org/SynchronetLogo.png)


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
4. Copy **clearpager** to **/sbbs/exec** - follow instructions about adding this as logout script in scfg
5. Copy **ackpager** to **/sbbs/exec** - follow instructions on adding sysop command

---
Use XRCed to edit the .xrc file
