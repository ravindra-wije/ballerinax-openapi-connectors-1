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

import  ballerina/http;
import  ballerina/url;
import  ballerina/lang.'string;

public type ClientConfig record {
    http:BearerTokenConfig|http:OAuth2RefreshTokenGrantConfig authConfig;
    http:ClientSecureSocket secureSocketConfig?;
};

public type ImageObjectArr ImageObject[];

# + clientEp - Connector http endpoint
@display {label: "Spotify Client"}
public client class Client {
    http:Client clientEp;
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://api.spotify.com/v1") returns error? {
        http:ClientSecureSocket? secureSocketConfig = clientConfig?.secureSocketConfig;
        http:Client httpEp = check new (serviceUrl, { auth: clientConfig.authConfig, secureSocket: secureSocketConfig });
        self.clientEp = httpEp;
    }
    # Get a List of Current User's Playlists
    #
    # + 'limit - 'The maximum number of playlists to return. Default: 20. Minimum: 1. Maximum: 50.'
    # + offset - 'The index of the first playlist to return. Default: 0 (the first object). Maximum offset: 100.000. Use with `limit` to get the next set of playlists.'
    # + return - On success, the HTTP status code in the response header is `200` OK and the response body contains an array of simplified [playlist objects](https://developer.spotify.com/documentation/web-api/reference/#object-simplifiedplaylistobject) (wrapped in a [paging object](https://developer.spotify.com/documentation/web-api/reference/#object-pagingobject)) in JSON format. On error, the header status code is an [error code](https://developer.spotify.com/documentation/web-api/#response-status-codes) and the response body contains an [error object](https://developer.spotify.com/documentation/web-api/#response-schema). Please note that the access token has to be tied to a user.
    @display {label: "My Playlists"}
    remote isolated function getMyPlaylists(@display {label: "Limit"} int? 'limit = (), @display {label: "Offset"} int? offset = ()) returns CurrentPlaylistDetails|error {
        string  path = string `/me/playlists`;
        map<anydata> queryParam = {'limit: 'limit, offset: offset};
        path = path + check getPathForQueryParam(queryParam);
        CurrentPlaylistDetails response = check self.clientEp-> get(path, targetType = CurrentPlaylistDetails);
        return response;
    }
    # Get a Playlist
    #
    # + playlist_id - The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    # + market - An [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) or the string `from_token`. Provide this parameter if you want to apply [Track
    # + fields - Filters for the query: a comma-separated list of the fields to return. If omitted, all fields are returned. For example, to get just the playlist''s description and URI: `fields=description,uri`. A dot separator can be used to specify non-reoccurring fields, while parentheses can be used to specify reoccurring fields within objects. For example, to get just the added date and user ID of the adder: `fields=tracks.items(added_at,added_by.id)`. Use multiple parentheses to drill down into nested objects, for example: `fields=tracks.items(track(name,href,album(name,href)))`. Fields can be excluded by prefixing them with an exclamation mark, for example: `fields=tracks.items(track(name,href,album(!name,href)))`
    # + additional_types - A comma-separated list of item types that your client supports besides the default `track` type. Valid types are: `track` and `episode`. **Note** : This parameter was introduced to allow existing clients to maintain their current behaviour and might be deprecated in the future. In addition to providing this parameter, make sure that your client properly handles cases of new types in the future by checking against the `type` field of each object.
    # + return - On success, the response body contains a [playlist object](https://developer.spotify.com/documentation/web-api/reference/#object-playlistobject) in JSON format and the HTTP status code in the response header is `200` OK. If an episode is unavailable in the given `market`, its information will not be included in the response. On error, the header status code is an [error code](https://developer.spotify.com/documentation/web-api/#response-status-codes) and the response body contains an [error object](https://developer.spotify.com/documentation/web-api/#response-schema). Requesting playlists that you do not have the user's authorization to access returns error `403` Forbidden.
    @display {label: "Playlist By Id"}
    remote isolated function getPlaylistById(@display {label: "Playlist Id"} string playlist_id, @display {label: "Market"} string? market = (), @display {label: "Fields to Return"} string? fields = (), @display {label: "Additional Types"} string? additional_types = ()) returns PlaylistObject|error {
        string  path = string `/playlists/${playlist_id}`;
        map<anydata> queryParam = {market: market, fields: fields, additional_types: additional_types};
        path = path + check getPathForQueryParam(queryParam);
        PlaylistObject response = check self.clientEp-> get(path, targetType = PlaylistObject);
        return response;
    }
    # Change a Playlist's Details
    #
    # + contentType - The content type of the request body: `application/json`  
    # + playlist_id - The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.  
    # + payload - Content to update the playlist
    # + return - On success the HTTP status code in the response header is `200` OK.
    @display {label: "Update Playlist"}
    remote isolated function updatePlaylist(@display {label: "Content Type"} string contentType, @display {label: "Playlist Id"} string playlist_id, ChangePlayListDetails payload) returns error? {
        string  path = string `/playlists/${playlist_id}`;
        map<any> headerValues = {"Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
         _ = check self.clientEp->put(path, request, headers = accHeaders, targetType=http:Response);
    }
    # Get a Playlist Cover Image
    #
    # + playlist_id - The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    # + return - On success, the response body contains a list of [image objects](https://developer.spotify.com/documentation/web-api/reference/#object-imageobject) in JSON format and the HTTP status code in the response header is `200` OK  
    @display {label: "Playlist Cover"}
    remote isolated function getPlaylistCover(@display {label: "Playlist Id"} string playlist_id) returns ImageObjectArr|error {
        string  path = string `/playlists/${playlist_id}/images`;
        ImageObjectArr response = check self.clientEp-> get(path, targetType = ImageObjectArr);
        return response;
    }
    # Upload a Custom Playlist Cover Image
    #
    # + contentType - The content type of the request body: `image/jpeg`
    # + playlist_id - The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    # + return - If you get status code `429`, it means that you have sent too many requests.
    @display {label: "Update Playlist Cover"}
    remote isolated function updatePlaylistCover(@display {label: "Content Type"} string contentType, @display {label: "Playlist Id"} string playlist_id) returns error? {
        string  path = string `/playlists/${playlist_id}/images`;
        map<any> headerValues = {"Content-Type": contentType};
        map<string|string[]> accHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
         _ = check self.clientEp-> put(path, request, headers = accHeaders, targetType=http:Response);
    }
    # Get a Playlist's Items
    #
    # + playlist_id - The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.
    # + market - An [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) or the string `from_token`. Provide this parameter if you want to apply [Track
    # + fields - Filters for the query: a comma-separated list of the fields to return. If omitted, all fields are returned. For example, to get just the total number of items and the request limit:  
    # + 'limit - The maximum number of items to return. Default: 100. Minimum: 1. Maximum: 100.
    # + offset - The index of the first item to return. Default: 0 (the first object).
    # + additional_types - A comma-separated list of item types that your client supports besides the default `track` type. Valid types are: `track` and `episode`. **Note** : This parameter was introduced to allow existing clients to maintain their current behaviour and might be deprecated in the future. In addition to providing this parameter, make sure that your client properly handles cases of new types in the future by checking against the `type` field of each object.
    # + return - On success, the response body contains an array of [track objects](https://developer.spotify.com/documentation/web-api/reference/#object-simplifiedtrackobject) and [episode objects](https://developer.spotify.com/documentation/web-api/reference/#object-simplifiedepisodeobject) (depends on the `additional_types` parameter), wrapped in a [paging object](https://developer.spotify.com/documentation/web-api/reference/#object-pagingobject) in JSON format and the HTTP status code in the response header is `200` OK. If an episode is unavailable in the given `market`, its information will not be included in the response. On error, the header status code is an [error code](https://developer.spotify.com/documentation/web-api/#response-status-codes) and the response body contains an [error object](https://developer.spotify.com/documentation/web-api/#response-schema). Requesting playlists that you do not have the user's authorization to access returns error `403` Forbidden.
    @display {label: "Playlist Tracks"}
    remote isolated function getPlaylistTracks(@display {label: "Playlist Id"} string playlist_id, @display {label: "Market"} string market, @display {label: "Fields to Return"} string? fields = (), @display {label: "Limit"} int? 'limit = (), @display {label: "Offset"} int? offset = (), string? additional_types = ()) returns PlaylistTrackDetails|error {
        string  path = string `/playlists/${playlist_id}/tracks`;
        map<anydata> queryParam = {market: market, fields: fields, 'limit: 'limit, offset: offset, additional_types: additional_types};
        path = path + check getPathForQueryParam(queryParam);
        PlaylistTrackDetails response = check self.clientEp-> get(path, targetType = PlaylistTrackDetails);
        return response;
    }
    # Reorder or Replace a Playlist's Items
    #
    # + playlist_id - The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the playlist.  
    # + payload - Information needed to reorder the playlist
    # + uris - A comma-separated list of [Spotify URIs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) to set, can be track or episode URIs. For example: `uris=spotify:track:4iV5W9uYEdYUVa79Axb7Rh,spotify:track:1301WleyT98MSxVHPZCA6M,spotify:episode:512ojhOuo1ktJprKbVcKyQ`  
    # + return - On a successful **reorder** operation, the response body contains a `snapshot_id` in JSON format
    @display {label: "Reorder or Replace Tracks"}
    remote isolated function reorderOrReplacePlaylistTracks(@display {label: "Playlist Id"} string playlist_id, PlayListReorderDetails payload, @display {label: "Track URIs"} string? uris = ()) returns SnapshotIdObject|error {
        string  path = string `/playlists/${playlist_id}/tracks`;
        map<anydata> queryParam = {uris: uris};
        path = path + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        SnapshotIdObject response = check self.clientEp->put(path, request, targetType=SnapshotIdObject);
        return response;
    }
    # Get a List of a User's Playlists
    #
    # + user_id - The user's [Spotify user ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids).
    # + 'limit - The maximum number of playlists to return. Default: 20. Minimum: 1. Maximum: 50.
    # + offset - The index of the first playlist to return. Default: 0 (the first object). Maximum offset: 100.000. Use with `limit` to get the next set of playlists.
    # + return - On success, the HTTP status code in the response header is `200` OK and the response body contains an array of simplified [playlist objects](https://developer.spotify.com/documentation/web-api/reference/#object-simplifiedplaylistobject) (wrapped in a [paging object](https://developer.spotify.com/documentation/web-api/reference/#object-pagingobject)) in JSON format. On error, the header status code is an [error code](https://developer.spotify.com/documentation/web-api/#response-status-codes) and the response body contains an [error object](https://developer.spotify.com/documentation/web-api/#response-schema).
    @display {label: "Playlist By User Id"}
    remote isolated function getPlayslistsByUserID(@display {label: "User Id"} string user_id, @display {label: "Limit"} int? 'limit = (), @display {label: "Offset"} int? offset = ()) returns UserPlayListDetails|error {
        string  path = string `/users/${user_id}/playlists`;
        map<anydata> queryParam = {'limit: 'limit, offset: offset};
        path = path + check getPathForQueryParam(queryParam);
        UserPlayListDetails response = check self.clientEp-> get(path, targetType = UserPlayListDetails);
        return response;
    }
    # Create a Playlist
    #
    # + user_id - The user's [Spotify user ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids).  
    # + payload - Content to create playlist
    # + return - On success, the response body contains the created [playlist object](https://developer.spotify.com/documentation/web-api/reference/#object-playlistobject)
    @display {label: "Create Playlist"}
    remote isolated function createPlaylist(@display {label: "User Id"} string user_id, PlayListDetails payload) returns PlaylistObject|error {
        string  path = string `/users/${user_id}/playlists`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody);
        PlaylistObject response = check self.clientEp->post(path, request, targetType=PlaylistObject);
        return response;
    }
}

# Generate query path with query parameter.
#
# + queryParam - Query parameter map
# + return - Returns generated Path or error at failure of client initialization
isolated function  getPathForQueryParam(map<anydata>   queryParam)  returns  string|error {
    string[] param = [];
    param[param.length()] = "?";
    foreach  var [key, value] in  queryParam.entries() {
        if  value  is  () {
            _ = queryParam.remove(key);
        } else {
            if  string:startsWith( key, "'") {
                 param[param.length()] = string:substring(key, 1, key.length());
            } else {
                param[param.length()] = key;
            }
            param[param.length()] = "=";
            if  value  is  string {
                string updateV =  check url:encode(value, "UTF-8");
                param[param.length()] = updateV;
            } else {
                param[param.length()] = value.toString();
            }
            param[param.length()] = "&";
        }
    }
    _ = param.remove(param.length()-1);
    if  param.length() ==  1 {
        _ = param.remove(0);
    }
    string restOfPath = string:'join("", ...param);
    return restOfPath;
}

# Generate header map for given header values.
#
# + headerParam - Headers  map
# + return - Returns generated map or error at failure of client initialization
isolated function  getMapForHeaders(map<any>   headerParam)  returns  map<string|string[]> {
    map<string|string[]> headerMap = {};
    foreach  var [key, value] in  headerParam.entries() {
        if  value  is  string ||  value  is  string[] {
            headerMap[key] = value;
        }
    }
    return headerMap;
}