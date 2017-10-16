# rfBro
Bro / Recorded Future Intel integration script

# Setup
Create directory and move script there:

`mkdir -p /home/$USER/bin/rf/ && mv rfBro.sh /home/$USER/bin/rf/rfBro.sh`

Edit script and add your Recorded Future API key to the variable APITOKEN:

`vim /home/$USER/bin/rf/rfBro.sh`

Edit crontab:

`crontab -e`

Add the following line (can be tweaked if you want job to run more/less often):

`30 0,3,7,11,13,15,19,23 * * * /home/$USER/bin/rf/rfBro.sh`

Every time the script runs it will query the Recorded Future API for all IPs, domains, and hashes with >= 65 risk rating. It will then format that intel for Bro and copy it to /opt/bro/share/bro/intel/intel.dat.

I've only tested this on a Security Onion master server. The built in Security Onion cron jobs will copy the intel out to all sensors automatically.

Cheers!
