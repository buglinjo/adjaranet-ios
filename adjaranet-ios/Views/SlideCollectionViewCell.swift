//
//  CollectionViewCell.swift
//  adjaranet-ios
//
//  Created by Irakli Tchitadze on 2/22/18.
//  Copyright © 2018 Buglinjo. All rights reserved.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleGeoTextView: UILabel!
    @IBOutlet weak var titleEngTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    let gradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        
        gl.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        gl.startPoint = CGPoint(x: 0.0, y: 0.5)
        gl.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gl
    }()
    
    func setupLayout() {
        self.titleGeoTextView = addShadow(label: titleGeoTextView)
        self.titleEngTextView = addShadow(label: titleEngTextView)
        imageView.backgroundColor = UIColor.red
        
        print(self.contentView.frame.width, self.contentView.frame.height)
//        gradientLayer.frame = self.layer.bounds
        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addShadow(label: UILabel) -> UILabel {
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 5.0
        label.layer.backgroundColor = UIColor.clear.cgColor
        
        return label
    }
}