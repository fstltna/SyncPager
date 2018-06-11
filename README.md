# SyncPager (1.0)
Alerts the Syncronet system operator that someone wants to talk to them

Official support sites: [Official Github Repo](https://github.com/fstltna/SyncPager), or mail to marisag@synchronetbbs.org

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


===outdated
3. Create a cron job to run several times per day like this:

        1 */6 * * * /root/mud-check-status/scan_mud_list.pl

