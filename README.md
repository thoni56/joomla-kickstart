# Joomla Kickstart Dockerfile

If you are running Joomla you are surely familiar with Akeeba Backup,
hopefully you are also using it!

Akeeba also has a Kickstart package that can take such a backup and
restore it on a new host, giving you the chance to tweak the
configuration to sute the new environment.

This is perfect for testing tweaks of your website, update of PHP and
what not.

Unfortunately this is a bit of a hazzle if you want to run that on a
development server.

But with the advent of Dockerized containers there is an opportunity
to make this a lot easier.

## What It Is

The Joomla project actually provides convenient Docker images for
setting up Joomla from scratch.

I decided to build a Docker image that would automatically install
everything required to run Joomla, download Akeeba Kickstart _and_ a
backup.

The idea is that you only need to spin up the container and, wham! you
are in the Kickstart restoration process!

## How to use

Build the image:

    make
	
Run the image

	make run

Navigate to the kickstart script on the containers port (http://localhost:8080/kickstart.php).

Select the backup, if not already selected, and press "Next". Follow the directions.

## Status

Works!

## Acknowledgements

Much of the Dockerfile, the docker-entrypoint.sh and some other stuff
is borrowed from the [Joomla
Docker](https://github.com/joomla-docker/docker-joomla) repo.
