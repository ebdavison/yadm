#!/bin/bash
export HTTP_PROXY=http://localhost:3128
export HTTPS_PROXY=http://localhost:3128
export NO_PROXY=localhost,127.0.0.1

nmcli conn modify "Talos Wired" proxy.method auto
nmcli conn modify "Talos Wired" proxy.pac-url "https://solid-constructs.com/tgsre.net.pac"
#nmcli conn up "Talos Wired"

/opt/Data/Software/HTTPie-2025.2.0.AppImage "$@"

#proxychains4 -f ~/bin/proxychains-tgsre.conf /opt/Data/Software/HTTPie-2025.2.0.AppImage 

nmcli conn modify "Talos Wired" proxy.method none
nmcli conn modify "Talos Wired" proxy.pac-url ""
#nmcli conn up "Talos Wired"

