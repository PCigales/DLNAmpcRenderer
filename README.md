# DLNAmpcRenderer
A script in Python 3 to turn mpc-hc into a DLNA / UPnP renderer 

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.

DLNAmpcRenderer is an application written in Python 3 designed as a wrapper for mpc-hc to use the player as a DLNA/UPnP renderer, on a computer running under Windows. The script does not need any other package, only the presence of an executable of mpc-hc is required. The application has been tested with a few DLNA controlers (Windows Media Player Digital Media Controller, Bubble UPnP, UPnPlay, DLNAPlayOn) but should work with any DLNA compliant controler. Subtitles management is enabled through the DIDL description ('subtitlefileuri' or 'captioninfo'/'captioninfoex' tags) or the use of a 'captioninfo.sec' header in the response to the HEAD/GET request for the content to be played. Several instances can run in parallel provided they use different ports and names.

To install the application:

  - of course, install Python 3
  - copy DLNAmpcRenderer.py, icon.png and mpc.bat in the same folder
  - install mpc-hc (https://github.com/clsid2/mpc-hc/releases) and madVR (http://madvr.com/) for proper image display and rotation
  - open mpc.bat and, if needed, change the path of mpc-hc executable
  - optionally, install jpegtran (https://jpegclub.org/jpegtran ), copy jpegtrans.bat, and change the path of jpegtran executable
  - allow mpc-hc and python to communicate through the firewall (for more precise needs, see below)

To run the application:

DLNAmpcRenderer -h to display the complete syntax of command line and abbreviated commands

DLNAmpcRenderer [-h] [--bind RENDERER_IP] [--port RENDERER_TCP_PORT] [--name RENDERER_NAME] [--minimize] [--fullscreen] [--rotate_jpeg ROTATE_MODE] [--wmpdmc_no_mkv] [--trust_controler] [--search_subtitles] [--no_part_req_intermediate] [--verbosity VERBOSE]

--bind RENDERER_IP: the ip address used by the renderer on the local machine for SSDP and sent to the controlers in the advertisements and the answers to the search requests (to set it manually if the script does not manage to self-determine the ip address of the host or to select a specific network interface)  
--port RENDERER_TCP_PORT: the port used by the renderer on the local machine sent to the controlers in the advertisements and the answers to the search requests  
--name RENDERER_NAME: the name of the renderer, used to generate the uuid  
--minimize: when set, minimizes the window of mpc-hc when inactive and restore it to its previous size when a playback is launched (useful when displaying photos as some controlers stop the playback between two consecutive pictures or when playing music as there is no use showing the window)  
--fullscreen: when set, makes mpc-hc go fullscreen each time a playback starts (can be combined with 'minimize')  
--rotate_jpeg ROTATE_MODE: when set to 'k' or 'j', tries to read the orientation metadata of jpeg pictures, and sends an accordingly rotation command to mpc-hc if 'k' (needs mpc-hc version 1.9.8.26 or higher to work properly), or sends a rotated picture with jpegtran to mpc_hc if 'j'  
--wmpdmc_no_mkv: when set, Windows Media Player Digital Media Controller will transcode 'mkv' (matroska) files to 'mpegts' before streaming the content, allowing remote control of the playback, otherwise, the 'mkv' file will be streamed as it is, and the seekbar will probably be inactive in WMPDMC (but available in mpc-hc)  
--trust_controler: when set, the URL of the content sent to the renderer is not checked before being passed to mpc-hc  
--search_subtitles: when set, always requests subtitles, trying different extensions if no subtitle uri is provided by the controler or the server (may slow down the process)  
--no_part_req_intermediate: when set, intermediates servers rejecting partial requests in order to allow mpc-hc to use Lav Splitter source (needs --trust_controler disabled)  
--verbosity VERBOSE: for troubleshooting purposes, from 0 (default) to 2  

Example: DLNAmpcRenderer -p 9100 -m -f -r j

As for the settings of the firewall, mpc-hc needs outgoing TCP connections allowed, and python outgoing TCP and UDP connections, as well as incoming TCP connections from local network on local port RENDERER_TCP_PORT (as in command line), incoming UDP connections from local network on local port 1900.

If with some files, in particular mpeg-ts contents, only audio is played, consider increasing the "stream analysis duration" of the "network settings" of Lav Splitter.
