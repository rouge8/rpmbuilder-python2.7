Python 2.7.5 RPMs
=================

Build RPMs for Python 2.7.5 on RHEL. Also builds RPMs for `setuptools`, `pip`, and `virtualenv` using the built Python 2.7.5 RPMs.

## Installing

Pre-built RPMs for RHEL 6.4 x86_64 can be found on the [releases page](https://github.com/rouge8/rpmbuilder-python2.7/releases).

## Building

```sh
vagrant up --provider=virtualbox --provision
vagrant ssh
/vagrant/build.sh  # creates 5 RPMs in repo root
```
