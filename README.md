# radiolivestream

This repository contains a Perl script that provides an easy interface to play
livestreams of various radio networks on linux systems. The script takes a name of the station as
its single argument, searches a list for the streaming url, and starts a program
playing the stream.

## Usage

```
livestream.pl <name of the broadcasting station>
```

**Note that the name of the broadcasting station does not contain any spaces.**

There are three additional (special) values that can be used as station names:

- `list`: The output of the function is an alphabetical list of station names
  separated by spaces.
- `query`: same as list, but every station takes a new line; it can be used if
  you want to search for a name
- `fulllist`: The output of the function is an alphabetical list of station name
  with the respective streaming url.

## Files

- `livestream.pl`: the main executable Perl script.
- `livestream.list`: a list of radio stations and streaming urls

## Player software

The script supports only `mpv` by now, but it is planned to extend the script to
use also MPlayer, vlc, and other software.

## Broken link?

If a streaming url is not working any more, please write me an issue. I will
check it as soon as possible.

## Additional radio stations?

If a radio station is missing in the list, you can always help me by writing an
issue containing the name (or names) of the station and the streaming url. I am
not familiar with the radio scene in many countries, so help is heavily
appreciated. I will mention you in the list of contibutors section.

## List of contributors

- Stefan Klinkusch (@sklinkusch)
