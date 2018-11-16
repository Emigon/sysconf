# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Triggerhappy is a lightweight hotkey daemon." \
HOMEPAGE=""
SRC_URI="https://github.com/wertarbyte/triggerhappy/archive/release/0.5.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="/var/tmp/portage/app-misc/triggerhappy-0.5.0/work/triggerhappy-release-0.5.0"

src_install() {
	echo ${S}
	emake DESTDIR="${D}" BINDIR="${D}/usr/bin/" S="" install
}
