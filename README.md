# SyncPager (1.0)
Alerts the Syncronet system operator that someone wants to talk to them

Official support sites: [Official Github Repo](https://github.com/fstltna/SyncPager), or mail to marisag@synchronetbbs.org

***

1. Use CPAN to install the following Perl modules:

        Email::Simple
        Email::Simple::Creator
        Email::Sender::Simple qw(sendmail)
	LWP::Simple


===outdated
3. Create a cron job to run several times per day like this:

        1 */6 * * * /root/mud-check-status/scan_mud_list.pl

