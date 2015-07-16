Summary: Pharaoh Tools - Full Open Source Suite
Name: php
Version: 1.0.1
Release: 0
License: Public
Group: Applications/System
Requires: php
Requires: git
%description
 This will install all available Pharaoh Tools on your system
 Enjoy
%install
 git clone https://github.com/PharaohTools/ptconfigure && sudo php ptconfigure/install-silent
 ptconfigure pharaohtools install -yg
%files
%post
 echo ..
 echo "Thanks for installing Pharaoh Tools"