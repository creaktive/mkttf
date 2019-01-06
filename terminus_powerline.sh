#!/bin/bash
set -e

wget --no-clobber --no-verbose "https://downloads.sourceforge.net/project/terminus-font/terminus-font-${TERMINUS_VERSION}/terminus-font-${TERMINUS_VERSION}.tar.gz"
rm -rf "terminus-font-${TERMINUS_VERSION}/"
tar xzf "terminus-font-${TERMINUS_VERSION}.tar.gz"
cd "terminus-font-${TERMINUS_VERSION}/"

mv ter-u12b.bdf{,.bak}
bdflib-embolden --ignore-spacing ter-u12b.bdf{.bak,}

ls *.bdf | xargs -n1 python /fontpatcher --no-rename
rename -f 's/-Powerline-\d+//' *.bdf

cd ..
rm -rf osx/ other_systems/ windows/
bash dist.sh "terminus-font-${TERMINUS_VERSION}" "${TERMINUS_VERSION}"
