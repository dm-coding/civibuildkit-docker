
# civibuild-docker
Efficient distribution of the CiviCRM buildkit in an Ubuntu 14.04 container.

As of this initial build-time, there are only two Civi images on the Docker hub, neither of which link to Github repositories of have READMEs, which hardly inspires confidence.

I have packaged up the CiviCRM buildkit from https://github.com/civicrm/civicrm-buildkit. This image downloads the buildkit, installs Apache and MySQL, and runs an installation script. The exact script is up to you, but by default the script is Drupal-base, which is the only one which has been tested to date.

# How to

* Run git clone https://github.com/civicrm/civicrm-buildkit.git

* Edit the Dockerfile which your preferred build script (view the available options here: https://github.com/civicrm/civicrm-buildkit/tree/master/app/config)

* Run docker build -t [script-name]

* Run the resulting docker image as normal

* Need to send email from the container? It has been configured with SSMTP -- just drop a working ssmtp.conf file into the image, either at buildtime by using the command "COPY ssmtp.conf /etc/ssmtp.conf" or at run time by using a volume mapper (.e.g -v /etc/ssmtp.conf:/etc/ssmtp.conf:ro) and email will work fine.

This is of course preferred to pulling the image directly from the Hub.

# Known bugs

* Other scripts have not been tested. Please help me test them!

* If you need to run post-install steps, you can add them in postinstall.sh

* Because we pull about 1.6GB of program data, github sometimes starts to rate limit us. Unfortunately, it may do this before we grab composer, which would allow us to set an access token.
