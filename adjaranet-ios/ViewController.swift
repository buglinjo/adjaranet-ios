//
//  ViewController.swift
//  adjaranet-ios
//
//  Created by Irakli Tchitadze on 2/21/18.
//  Copyright © 2018 Buglinjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let logo = UIImageView(image: UIImage(named: "adjaranet"))
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        logo.contentMode = .scaleAspectFit
        navigationItem.titleView = logo
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        collectionView.backgroundColor = .red
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCellId", for: indexPath) as! CollectionViewCell

        cell.backgroundColor = .green
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

