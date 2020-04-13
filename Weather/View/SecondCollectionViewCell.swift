//
//  SecondCollectionViewCell.swift
//  Weather
//
//  Created by Mikhail Ladutska on 4/1/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    var okButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addSubview(okButton)
        okButton.center.x = contentView.center.x - 60
        okButton.center.y = contentView.center.y - 20
        
        let tutorialLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 120, height: 50))
        tutorialLabel.translatesAutoresizingMaskIntoConstraints = false

        
        tutorialLabel.backgroundColor = .red
        tutorialLabel.text = "Tutorial Screen 2"
        tutorialLabel.sizeToFit()
        addSubview(tutorialLabel)
                
    }
    
}
