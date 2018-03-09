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
    
    let gradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        
        gl.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        gl.startPoint = CGPoint(x: 0.0, y: 0.5)
        gl.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    func setupLayout() {
        gradientLayer.frame = self.layer.bounds
        imageView.layer.addSublayer(gradientLayer)
        
        self.titleGeoTextView.dropShadow(color: .black, opacity: 1, offset: CGSize.zero, radius: 5)
        self.titleEngTextView.dropShadow(color: .black, opacity: 1, offset: CGSize.zero, radius: 5)
    }
}
