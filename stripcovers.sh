#!/usr/bin/env bash

if [ ! $# -eq 1 ] || [ ! -d $1 ]; then
  echo "😃 hello, give me a valid directory to work with"
  exit
fi

if [ ! -d "stripped_covers" ]; then
  mkdir stripped_covers
fi

cd stripped_covers || exit
destDir=$(pwd)

cd "../$1" || exit

for artist in */ .*/ ; do 

  if [ "$artist" = "./" ] || [ "$artist" = "../" ] || [ "$artist" = "*/" ] || [ ! -d "$artist" ]; then continue; fi; 
  
  echo "🎤 ARTIST: $artist";
  cd "$artist" || continue

  destArtistDir="${destDir}/${artist}"
  if [ ! -d "$destArtistDir" ]; then
    mkdir "$destArtistDir"
  fi

  for album in */ .*/ ; do 

    if [ "$album" = "./" ] || [ "$album" = "../" ] || [ "$album" = "*/" ]; then continue; fi;

    echo "    💿 ALBUM: $album";
    cd "$album" || continue

    count=`ls -1 *.flac 2>/dev/null | wc -l`
    if [ $count = 0 ]; then 
      echo "        🥴 not an album, flac files are missing"
      cd ..
      continue
    fi 

    destAlbumDir="${destArtistDir}${album}"
    if [ -d "$destAlbumDir" ]; then
      echo "        ⏭️  already exists, skipping"
      cd ..
      continue
    fi

    originAlbumDir=$(pwd)

    echo "        📂 creating directory"
    mkdir "$destAlbumDir"

    echo "        💾 copying files"
    cp *.flac "$destAlbumDir"
    
    cd "$destAlbumDir"

    for song in *; do 
      echo "        🎨 extracting cover from $song"
      metaflac --export-picture-to=cover.jpg "$song" && break
    done
    
    echo "        🧹 removing covers from tags"
    metaflac --remove --block-type=PICTURE,PADDING --dont-use-padding *.flac
    metaflac --remove-tag=COVERART  --dont-use-padding *.flac
    cd "$originAlbumDir/.."

  done

  cd ..

  if [ ! "$(ls -A "$destArtistDir")" ]; then rmdir $destArtistDir; fi;

done
