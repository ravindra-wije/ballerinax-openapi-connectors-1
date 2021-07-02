// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Information needed to reorder the playlist
public type PlayListReorderDetails record {
    # The position where the items should be inserted.  
    int insert_before?;
    # The amount of items to be reordered. Defaults to 1 if not set.  
    int range_length?;
    # The position of the first item to be reordered.
    int range_start?;
    # The playlist's snapshot ID against which you want to make the changes.
    string snapshot_id?;
    # A comma-separated list of [Spotify URIs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) to set, can be track or episode URIs. For example: `uris=spotify:track:4iV5W9uYEdYUVa79Axb7Rh,spotify:track:1301WleyT98MSxVHPZCA6M,spotify:episode:512ojhOuo1ktJprKbVcKyQ`  
    string[] uris?;
};

# Content to update the playlist
public type ChangePlayListDetails record {
    # If `true` , the playlist will become collaborative and other users will be able to modify the playlist in their Spotify client. *Note: You can only set `collaborative` to `true` on non-public playlists.*
    boolean collaborative?;
    # Value for playlist description as displayed in Spotify Clients and in the Web API.
    string description?;
    # The new name for the playlist, for example `"My New Playlist Title"`
    string name?;
    # If `true` the playlist will be public, if `false` it will be private.
    boolean 'public?;
};

public type LinkedTrackObject record {
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the track.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    string id?;
    # The object type: "track".
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    string uri?;
};

public type PlaylistTrackObject record {
    # The date and time the track or episode was added. *Note that some very old playlists may return `null` in this field.*
    string added_at?;
    PublicUserObject added_by?;
    # Whether this track or episode is a [local file](https://developer.spotify.com/web-api/local-files-spotify-playlists/) or not.
    boolean is_local?;
    # Information about the track or episode.
    TrackObject|EpisodeObject track?;
};

public type SimplifiedArtistObject record {
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the artist.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the artist.
    string id?;
    # The name of the artist.
    string name?;
    # The object type: `"artist"`
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the artist.
    string uri?;
};

public type TrackRemovingDetails record {
    # The playlist's snapshot ID against which you want to make the changes. The API will validate that the specified items exist and in the specified positions and make the changes, even if more recent changes have been made to the playlist.
    string snapshot_id?;
    # An array of objects containing [Spotify URIs](https://developer.spotify.com/spotify-documentation/web-api/#spotify-uris-and-ids) of the tracks or episodes to remove. For example: `{ "tracks": [{ "uri": "spotify:track:4iV5W9uYEdYUVa79Axb7Rh" },{ "uri": "spotify:track:1301WleyT98MSxVHPZCA6M" }] }`. A maximum of 100 objects can be sent at once.
    string[] tracks;
};

public type EpisodeObject record {
    # A URL to a 30 second preview (MP3 format) of the episode. `null` if not available.
    string audio_preview_url?;
    # A description of the episode. HTML tags are stripped away from this field, use `html_description` field in case HTML tags are needed.
    string description?;
    # The episode length in milliseconds.
    int duration_ms?;
    # Whether or not the episode has explicit content (true = yes it does; false = no it does not OR unknown).
    boolean explicit?;
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the episode.
    string href?;
    # A description of the episode. This field may contain HTML tags.
    string html_description?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the episode.
    string id?;
    # The cover art for the episode in various sizes, widest first.
    ImageObject[] images?;
    # True if the episode is hosted outside of Spotify's CDN.
    boolean is_externally_hosted?;
    # True if the episode is playable in the given market. Otherwise false.
    boolean is_playable?;
    # **Note: This field is deprecated and might be removed in the future. Please use the `languages` field instead.** The language used in the episode, identified by a [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code.
    string language?;
    # A list of the languages used in the episode, identified by their [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code.
    string[] languages?;
    # The name of the episode.
    string name?;
    # The date the episode was first released, for example `"1981-12-15"`. Depending on the precision, it might be shown as `"1981"` or `"1981-12"`.
    string release_date?;
    # The precision with which `release_date` value is known: `"year"`, `"month"`, or `"day"`.
    string release_date_precision?;
    EpisodeRestrictionObject restrictions?;
    ResumePointObject resume_point?;
    SimplifiedShowObject show?;
    # The object type: "episode".
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the episode.
    string uri?;
};

# Playlist details
public type PlayListDetails record {
    # Defaults to `false` . If `true` the playlist will be collaborative. Note that to create a collaborative playlist you must also set `public` to `false` . To create collaborative playlists you must have granted `playlist-modify-private` and `playlist-modify-public` [scopes](https://developer.spotify.com/documentation/general/guides/authorization-guide/#list-of-scopes) .
    boolean collaborative?;
    # value for playlist description as displayed in Spotify Clients and in the Web API.
    string description?;
    # The name for the new playlist, for example `"Your Coolest Playlist"` . This name does not need to be unique; a user may have several playlists with the same name.
    string name;
    # Defaults to `true` . If `true` the playlist will be public, if `false` it will be private. To be able to create private playlists, the user must have granted the `playlist-modify-private` [scope](https://developer.spotify.com/documentation/general/guides/authorization-guide/#list-of-scopes)
    boolean 'public?;
};

public type ExternalUrlObject record {
    # The [Spotify URL](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the object.
    string spotify?;
};

public type SimplifiedAlbumObject record {
    # The field is present when getting an artist's albums. Possible values are "album", "single", "compilation", "appears_on". Compare to album_type this field represents relationship between the artist and the album.
    string album_group?;
    # The type of the album: one of "album", "single", or "compilation".
    string album_type?;
    # The artists of the album. Each artist object includes a link in `href` to more detailed information about the artist.
    SimplifiedArtistObject[] artists?;
    # The markets in which the album is available: [ISO 3166-1 alpha-2 country codes](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). Note that an album is considered available in a market when at least 1 of its tracks is available in that market.
    string[] available_markets?;
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the album.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the album.
    string id?;
    # The cover art for the album in various sizes, widest first.
    ImageObject[] images?;
    # The name of the album. In case of an album takedown, the value may be an empty string.
    string name?;
    # The date the album was first released, for example `1981`. Depending on the precision, it might be shown as `1981-12` or `1981-12-15`.
    string release_date?;
    # The precision with which `release_date` value is known: `year` , `month` , or `day`.
    string release_date_precision?;
    AlbumRestrictionObject restrictions?;
    # The total number of tracks in the album.
    int total_tracks?;
    # The object type: "album"
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the album.
    string uri?;
};

public type FollowersObject record {
    # A link to the Web API endpoint providing full details of the followers; `null` if not available. Please note that this will always be set to null, as the Web API does not support it at the moment.
    string? href?;
    # The total number of followers.
    int total?;
};

public type CopyrightObject record {
    # The copyright text for this content.
    string text?;
    # The type of copyright: `C` = the copyright, `P` = the sound recording (performance) copyright.
    string 'type?;
};

public type CurrentPlaylistDetails record {
    # A link to the Web API endpoint returning the full result of the request
    string href?;
    # The requested data.
    SimplifiedPlaylistObject[] items?;
    # The maximum number of items in the response (as set in the query or by default).
    int 'limit?;
    # URL to the next page of items. ( `null` if none)
    string? next?;
    # The offset of the items returned (as set in the query or by default)
    int offset?;
    # URL to the previous page of items. ( `null` if none)
    string? previous?;
    # The total number of items available to return.
    int total?;
};

public type ErrorResponseObject record {
    ErrorObject _error?;
};

public type SimplifiedPlaylistObject record {
    # `true` if the owner allows other users to modify the playlist.
    boolean collaborative?;
    # The playlist description. *Only returned for modified, verified playlists, otherwise* `null`.
    string description?;
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the playlist.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    string id?;
    # Images for the playlist. The array may be empty or contain up to three images. The images are returned by size in descending order. See [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/). *Note: If returned, the source URL for the image (`url`) is temporary and will expire in less than a day.*
    ImageObject[] images?;
    # The name of the playlist.
    string name?;
    PublicUserObject owner?;
    # The playlist's public/private status: `true` the playlist is public, `false` the playlist is private, `null` the playlist status is not relevant. For more about public/private status, see [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/)
    boolean 'public?;
    # The version identifier for the current playlist. Can be supplied in other requests to target a specific playlist version
    string snapshot_id?;
    PlaylistTracksRefObject tracks?;
    # The object type: "playlist"
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    string uri?;
};

public type PlaylistTrackDetails record {
    # A link to the Web API endpoint returning the full result of the request
    string href?;
    # The requested data.
    PlaylistTrackObject[] items?;
    # The maximum number of items in the response (as set in the query or by default).
    int 'limit?;
    # URL to the next page of items. ( `null` if none)
    string? next?;
    # The offset of the items returned (as set in the query or by default)
    int offset?;
    # URL to the previous page of items. ( `null` if none)
    string? previous?;
    # The total number of items available to return.
    int total?;
};

public type EpisodeRestrictionObject record {
    # The reason for the restriction. Supported values:  
    string reason?;
};

public type ImageObject record {
    # The image height in pixels. If unknown: `null` or not returned.
    int height?;
    # The source URL of the image.
    string url?;
    # The image width in pixels. If unknown: `null` or not returned.
    int width?;
};

public type ErrorObject record {
    # A short description of the cause of the error.
    string message?;
    # The HTTP status code (also returned in the response header; see [Response Status Codes](https://developer.spotify.com/documentation/web-api/#response-status-codes) for more information).
    int status?;
};

public type PublicUserObject record {
    # The name displayed on the user's profile. `null` if not available.
    string display_name?;
    ExternalUrlObject external_urls?;
    FollowersObject followers?;
    # A link to the Web API endpoint for this user.
    string href?;
    # The [Spotify user ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for this user.
    string id?;
    # The user's profile image.
    ImageObject[] images?;
    # The object type: "user"
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for this user.
    string uri?;
};

public type TrackRestrictionObject record {
    # The reason for the restriction. Supported values:  
    string reason?;
};

public type UserPlayListDetails record {
    # A link to the Web API endpoint returning the full result of the request
    string href?;
    # The requested data.
    SimplifiedPlaylistObject[] items?;
    # The maximum number of items in the response (as set in the query or by default).
    int 'limit?;
    # URL to the next page of items. ( `null` if none)
    string? next?;
    # The offset of the items returned (as set in the query or by default)
    int offset?;
    # URL to the previous page of items. ( `null` if none)
    string? previous?;
    # The total number of items available to return.
    int total?;
};

public type TrackObject record {
    SimplifiedAlbumObject album?;
    # The artists who performed the track. Each artist object includes a link in `href` to more detailed information about the artist.
    ArtistObject[] artists?;
    # A list of the countries in which the track can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
    string[] available_markets?;
    # The disc number (usually `1` unless the album consists of more than one disc).
    int disc_number?;
    # The track length in milliseconds.
    int duration_ms?;
    # Whether or not the track has explicit lyrics ( `true` = yes it does; `false` = no it does not OR unknown).
    boolean explicit?;
    ExternalIdObject external_ids?;
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the track.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    string id?;
    # Whether or not the track is from a local file.
    boolean is_local?;
    # Part of the response when [Track Relinking](https://developer.spotify.com/documentation/general/guides/track-relinking-guide/) is applied. If `true` , the track is playable in the given market. Otherwise `false`.
    boolean is_playable?;
    LinkedTrackObject linked_from?;
    # The name of the track.
    string name?;
    # The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.  
    int popularity?;
    # A link to a 30 second preview (MP3 format) of the track. Can be `null`
    string preview_url?;
    TrackRestrictionObject restrictions?;
    # The number of the track. If an album has several discs, the track number is the number on the specified disc.
    int track_number?;
    # The object type: "track".
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
    string uri?;
};

public type ArtistObject record {
    ExternalUrlObject external_urls?;
    FollowersObject followers?;
    # A list of the genres the artist is associated with. For example: `"Prog Rock"` , `"Post-Grunge"`. (If not yet classified, the array is empty.)
    string[] genres?;
    # A link to the Web API endpoint providing full details of the artist.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the artist.
    string id?;
    # Images of the artist in various sizes, widest first.
    ImageObject[] images?;
    # The name of the artist.
    string name?;
    # The popularity of the artist. The value will be between 0 and 100, with 100 being the most popular. The artist's popularity is calculated from the popularity of all the artist's tracks.
    int popularity?;
    # The object type: `"artist"`
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the artist.
    string uri?;
};

public type PlaylistTrackInsertionDetails record {
    # The position to insert the items, a zero-based index. For example, to insert the items in the first position: `position=0` ; to insert the items in the third position: `position=2`. If omitted, the items will be appended to the playlist. Items are added in the order they appear in the uris array. For example: `{"uris": ["spotify:track:4iV5W9uYEdYUVa79Axb7Rh","spotify:track:1301WleyT98MSxVHPZCA6M"], "position": 3}`
    int position?;
    # A JSON array of the [Spotify URIs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) to add. For example: `{"uris": ["spotify:track:4iV5W9uYEdYUVa79Axb7Rh","spotify:track:1301WleyT98MSxVHPZCA6M", "spotify:episode:512ojhOuo1ktJprKbVcKyQ"]}`  
    string[] uris?;
};

public type SnapshotIdObject record {
    # The snapshot_id can be used to identify your playlist version in future requests.
    string snapshot_id?;
};

public type PlaylistTracksRefObject record {
    # A link to the Web API endpoint where full details of the playlist's tracks can be retrieved.
    string href?;
    # Number of tracks in the playlist.
    int total?;
};

public type SimplifiedShowObject record {
    # A list of the countries in which the show can be played, identified by their [ISO 3166-1 alpha-2](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.
    string[] available_markets?;
    # The copyright statements of the show.
    CopyrightObject[] copyrights?;
    # A description of the show. HTML tags are stripped away from this field, use `html_description` field in case HTML tags are needed.
    string description?;
    # Whether or not the show has explicit content (true = yes it does; false = no it does not OR unknown).
    boolean explicit?;
    ExternalUrlObject external_urls?;
    # A link to the Web API endpoint providing full details of the show.
    string href?;
    # A description of the show. This field may contain HTML tags.
    string html_description?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the show.
    string id?;
    # The cover art for the show in various sizes, widest first.
    ImageObject[] images?;
    # True if all of the show's episodes are hosted outside of Spotify's CDN. This field might be `null` in some cases.
    boolean is_externally_hosted?;
    # A list of the languages used in the show, identified by their [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code.
    string[] languages?;
    # The media type of the show.
    string media_type?;
    # The name of the episode.
    string name?;
    # The publisher of the show.
    string publisher?;
    # The object type: "show".
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the show.
    string uri?;
};

public type AlbumRestrictionObject record {
    # The reason for the restriction. Supported values:  
    string reason?;
};

public type PlaylistObject record {
    # `true` if the owner allows other users to modify the playlist.
    boolean collaborative?;
    # The playlist description. *Only returned for modified, verified playlists, otherwise* `null`.
    string description?;
    ExternalUrlObject external_urls?;
    FollowersObject followers?;
    # A link to the Web API endpoint providing full details of the playlist.
    string href?;
    # The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    string id?;
    # Images for the playlist. The array may be empty or contain up to three images. The images are returned by size in descending order. See [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/). *Note: If returned, the source URL for the image (`url`) is temporary and will expire in less than a day.*
    ImageObject[] images?;
    # The name of the playlist.
    string name?;
    PublicUserObject owner?;
    # The playlist's public/private status: `true` the playlist is public, `false` the playlist is private, `null` the playlist status is not relevant. For more about public/private status, see [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/)
    boolean 'public?;
    # The version identifier for the current playlist. Can be supplied in other requests to target a specific playlist version
    string snapshot_id?;
    # Information about the tracks of the playlist. Note, a track object may be `null`. This can happen if a track is no longer available.
    record  { # A link to the Web API endpoint returning the full result of the request
        string href?; # The requested data.
        PlaylistTrackObject[] items?; # The maximum number of items in the response (as set in the query or by default).
        int 'limit?; # URL to the next page of items. ( `null` if none)
        string? next?; # The offset of the items returned (as set in the query or by default)
        int offset?; # URL to the previous page of items. ( `null` if none)
        string? previous?; # The total number of items available to return.
        int total?;}  tracks?;
    # The object type: "playlist"
    string 'type?;
    # The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    string uri?;
};

public type ResumePointObject record {
    # Whether or not the episode has been fully played by the user.
    boolean fully_played?;
    # The user's most recent position in the episode in milliseconds.
    int resume_position_ms?;
};

public type ExternalIdObject record {
    # [International Article Number](http://en.wikipedia.org/wiki/International_Article_Number_%28EAN%29)
    string ean?;
    # [International Standard Recording Code](http://en.wikipedia.org/wiki/International_Standard_Recording_Code)
    string isrc?;
    # [Universal Product Code](http://en.wikipedia.org/wiki/Universal_Product_Code)
    string upc?;
};
