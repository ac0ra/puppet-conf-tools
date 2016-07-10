#!/bin/bash
#
#
# Author = 'Adam Grigolato'
# Version = '0'
#
#
#
usage="$(basename "$0") [-h] [-d DIRECTORY] -- Program to install pupcon

where:
    -h  show this help text
    -d  set the pupcon install dir, default(~/.pupcon)"

installdir=~/.pupcon
while getopts ':hd:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    d) installdir=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
inform() { echo "$*" && "$@"; } 

if [ ! -d $installdir ]
then
	mkdir $installdir
else
	printf "Install Directory already exists, bailing so no data is clobbered\n"
	exit 111
fi

buildpupcon() {
	printf "Building Directories\n"
	inform mkdir $installdir/bin
	inform mkdir $installdir/repos
	inform mkdir $installdir/configs
	inform mkdir $installdir/share
	printf "Cloning Components\n"
	try git clone https://github.com/ac0ra/puppet-conf-tools.git $installdir/share/pupcon-src
	try git clone https://github.com/jordansissel/puppet-examples.git $installdir/configs/puppet-examples
	try git clone https://github.com/puppetlabs/control-repo.git $installdir/share/control-repo
	printf "Cloning Optional Components\n"
	inform git clone https://github.com/ac0ra/puppet-res.git $installdir/configs/puppet-res
	inform git clone https://github.com/ac0ra/puppet-res-priv.git $installdir/configs/puppet-private-res
	printf "Preparing Pupcon\n"
	try cp $installdir/share/pupcon-src/src/scripts/* $installdir/bin/
	try virtualenv --no-site-packages --distribute $installdir/venv
	try source $installdir/venv/bin/activate
	try pip install -r $installdir/share/pupcon-src/requirements.txt
}

buildpupcon
