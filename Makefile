PROJECT=encyc
APP=encycfrontassets
USER=encyc

SHELL = /bin/bash
DEBIAN_CODENAME := $(shell lsb_release -sc)
DEBIAN_RELEASE := $(shell lsb_release -sr)
VERSION := $(shell cat VERSION)

GIT_SOURCE_URL=https://github.com/densho/encyc-front-assets

INSTALL_BASE=/opt
INSTALLDIR=$(INSTALL_BASE)/encyc-front-assets

MEDIA_BASE=/var/www/html/front
MEDIA_ROOT=$(MEDIA_BASE)/media
STATIC_ROOT=$(MEDIA_BASE)/static

FPM_BRANCH := $(shell git rev-parse --abbrev-ref HEAD | tr -d _ | tr -d -)
FPM_ARCH=amd64
FPM_NAME=$(APP)-$(FPM_BRANCH)
FPM_FILE=$(FPM_NAME)_$(VERSION)_$(FPM_ARCH).deb
FPM_VENDOR=Densho.org
FPM_MAINTAINER=<geoffrey.jost@densho.org>
FPM_DESCRIPTION=Densho Encyclopedia assets
FPM_BASE=opt/encyc-front-assets


.PHONY: help


help:
	@echo "encyc-front-assets Install Helper"
	@echo "See: make howto-install"

help-all:
	@echo "install - Do a fresh install"

howto-install:
	@echo "TBD"


# http://fpm.readthedocs.io/en/latest/
# https://stackoverflow.com/questions/32094205/set-a-custom-install-directory-when-making-a-deb-package-with-fpm
# https://brejoc.com/tag/fpm/
deb:
	@echo ""
	@echo "FPM packaging ----------------------------------------------------------"
	-rm -Rf $(FPM_FILE)
	fpm   \
	--verbose   \
	--input-type dir   \
	--output-type deb   \
	--name $(FPM_NAME)   \
	--version $(VERSION)   \
	--package $(FPM_FILE)   \
	--url "$(GIT_SOURCE_URL)"   \
	--vendor "$(FPM_VENDOR)"   \
	--maintainer "$(FPM_MAINTAINER)"   \
	--description "$(FPM_DESCRIPTION)"   \
	--chdir $(INSTALLDIR)   \
	media=var/www/html/front   \
	static=var/www/html/front   \
	.git=$(FPM_BASE)   \
	.gitignore=$(FPM_BASE)   \
	media=$(FPM_BASE)   \
	static=$(FPM_BASE)   \
	INSTALL=$(FPM_BASE)   \
	Makefile=$(FPM_BASE)   \
	README=$(FPM_BASE)   \
	VERSION=$(FPM_BASE)
