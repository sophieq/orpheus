//
//  PlayerViewController.swift
//  Orpheus
//
//  Created by Sophie Qin on 2020-05-14.
//  Copyright © 2020 Sophie Qin. All rights reserved.
//

import Cocoa

class PlayerViewController: NSViewController {

    
    let currentTrack: SongTrack
    let titleLabel = NSTextField(string: "default string")
    let artistLabel = NSTextField(string: "default string")
    
    init(currentTrack: SongTrack) {
        self.currentTrack = currentTrack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.stringValue = currentTrack.title
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        self.view.addSubview(titleLabel)
        
        artistLabel.stringValue = currentTrack.artist
        artistLabel.isEditable = false
        artistLabel.isSelectable = false
        self.view.addSubview(artistLabel)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
        ]
        
        let artistLabelConstraint: [NSLayoutConstraint] = [
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            artistLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            artistLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            artistLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        ]
        
        var constraints: [NSLayoutConstraint] = []
        constraints += titleLabelConstraints
        constraints += artistLabelConstraint
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func updateSongTrack(_ notification: NSNotification?) {
        
        print("userInfo: ", notification?.userInfo ?? "")
        
        guard let notification = notification,
            let dict = notification.userInfo,
        let title = dict["Name"] as? String,
        let artist = dict["Artist"] as? String else {
                return
        }
        
        titleLabel.stringValue = title
        artistLabel.stringValue = artist
    }
    
//        NSApplication.shared.terminate(sender)
}
