//
//  PlayerViewController.swift
//  Orpheus
//
//  Created by Sophie Qin on 2020-05-14.
//  Copyright © 2020 Sophie Qin. All rights reserved.
//

import Cocoa

class PlayerViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var authorLabel: NSTextField!
    
    @IBAction func onQuit(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
