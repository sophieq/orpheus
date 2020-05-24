//
//  AppDelegate.swift
//  Orpheus
//
//  Created by Sophie Qin on 2020-05-14.
//  Copyright © 2020 Sophie Qin. All rights reserved.
//

import Cocoa
import ScriptingBridge

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(togglePopover(_:))
        }
        
        // get current track
        let title = Scripts.getTitle.runScript()
        let artist = Scripts.getAlbum.runScript()
        let album = Scripts.getAlbum.runScript()
        let albumUrl = Scripts.getAlbumArtwork.runScript()
        
        let currentTrack = SongTrack(
            title: title,
            artist: artist,
            album: album,
            albumUrl: albumUrl
        )
        
        let playViewController = PlayerViewController(currentTrack: currentTrack)
        popover.contentViewController = playViewController
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let strongSelf = self,
                strongSelf.popover.isShown {
                strongSelf.closePopover(sender: event)
            }
        }
        
        let spotifyApp = SBApplication(bundleIdentifier: "com.spotify.client")
        
        if let _ = spotifyApp?.isRunning {
            let notificationCenter = DistributedNotificationCenter.default()
            notificationCenter.addObserver(
                playViewController,
                selector: #selector(playViewController.updateSongTrack(_:)),
                name: NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged"),
                object: nil
            )
        } else {
            // default screen
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}

