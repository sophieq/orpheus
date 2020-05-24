//
//  Scripts.swift
//  Orpheus
//
//  Created by Sophie Qin on 2020-05-23.
//  Copyright © 2020 Sophie Qin. All rights reserved.
//

import Foundation

enum Scripts {
    case getTitle
    case getArtist
    case getAlbum
    case getAlbumArtwork
    
    func rawValue() -> String {
        switch self {
        case .getTitle:
            return "tell application \"Spotify\" to return name of current track"
        case .getArtist:
            return "tell application \"Spotify\" to return artist of current track"
        case .getAlbum:
            return "tell application \"Spotify\" to return album of current track"
        case .getAlbumArtwork:
            return "tell application \"Spotify\" to return artwork url of current track"
        }
    }
    
    func runScript() -> String {
        let script = self.rawValue()
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            if let outputString = scriptObject.executeAndReturnError(&error).stringValue {
                return outputString
            } else if (error != nil) {
                return "error: " + error!.description
            }
        }
        return "error: script could not run"
    }
}

