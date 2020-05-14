//
//  AppDelegate.swift
//  orpheus
//
//  Created by Sophie Qin on 2020-05-13.
//  Copyright © 2020 Sophie Qin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(openMenu(_:))
        }
        
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    @objc func openMenu(_ sender: Any?) {
        print("hello")
    }

}

