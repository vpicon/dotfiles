#! /usr/bin/python3
import dbus


def spotify_metadata(session_bus):
    title = ""
    artist = ""

    try:
        # Obtain metadata from dbus object
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify",
                                             "/org/mpris/MediaPlayer2")
        spotify_properties = dbus.Interface(spotify_bus,
                                            "org.freedesktop.DBus.Properties")
        metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")
    except:
        raise RuntimeError('Failed to fetch spotify data')
    else: 
        # Get artist and title fields
        title = metadata['xesam:title']
        artist = metadata['xesam:artist'][0]
    
    return (title, artist)



if __name__ == "__main__":
    session_bus = dbus.SessionBus()
    (title, artist) = spotify_metadata(session_bus)
    print(title, "-", artist)
