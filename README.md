# stripcovers
### A silly tiny bash script to strip covers from flac files

Extract any embedded coverart from a flac file and saves it on a cover.jpg file before removing the "picture" and "coverart" tags

### Dependency

metaflac command line tool from the official flac packages
```sh
sudo apt install flac
```

### Usage
```
sh stripcovers.sh <music_collection_directory>
```
This will make a copy of ```<music_collection_directory>``` under the ```stripped_covers``` directory with all the flac files stripped from their covers. Coverart is saved on a single cover.jpg file for every album found.

### Expected music collection directory structure
```
📂 artist_directory
  📂 album_directory
    📄 song.flac
    📄 song.flac
    📄 ....
  📂 album_directory
    📄 song.flac
    📄 ...
📂 artist_directory
  📂 album_directory
    📄 song.flac
    📄 ....
```
### Documentation
https://xiph.org/flac/documentation_tools_metaflac.html

_RAVINDRA Soudakar - 2023_
