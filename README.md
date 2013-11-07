Python 2.7.5 RPMs
=================

Build RPMs for Python 2.7.5 on RHEL. Also builds RPMs for `setuptools`, `pip`, and `virtualenv` using the built Python 2.7.5 RPMs.

## Usage

```sh
vagrant up --provider=virtualbox --provision
vagrant ssh
/vagrant/build.sh  # creates 5 RPMs in repo root
```
