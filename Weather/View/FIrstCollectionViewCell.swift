//
//  FIrstCollectionViewCell.swift
//  Weather
//
//  Created by Mikhail Ladutska on 3/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class FIrstCollectionViewCell: UICollectionViewCell {
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.frame.size.width = 80
        button.frame.size.height = 40
        button.setTitle("Next", for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.updateButtonState(notification:)),
        name: Notification.Name("didChangeAuthorizationWhenInUse"),
        object: nil)
        nextButton.center = self.contentView.center
        addSubview(nextButton)
        
       
       let tutorialLabel = UILabel()
        tutorialLabel.translatesAutoresizingMaskIntoConstraints = false
        tutorialLabel.frame.size.height = 50
        tutorialLabel.frame.size.width = 120
        tutorialLabel.center.x = self.center.x
        tutorialLabel.center.y = 100
        tutorialLabel.backgroundColor = .red
        tutorialLabel.text = "Tutorial Screen 1"
        tutorialLabel.sizeToFit()
        addSubview(tutorialLabel)
    }
    
    @objc func updateButtonState(notification: Notification) {
        nextButton.isEnabled = true
    }
    
}
