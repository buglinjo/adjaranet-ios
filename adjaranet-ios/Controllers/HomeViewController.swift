//
//  ViewController.swift
//  adjaranet-ios
//
//  Created by Irakli Tchitadze on 2/21/18.
//  Copyright © 2018 Buglinjo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let logo = UIImageView(image: UIImage(named: "adjaranet"))
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.contentMode = .scaleAspectFit
        navigationItem.titleView = logo
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        self.refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCellId", for: indexPath) as! HeaderTableViewCell
            
            cell.collectionView.collectionViewLayout.invalidateLayout()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCellId", for: indexPath) as! SectionTableViewCell
            
            cell.collectionView.collectionViewLayout.invalidateLayout()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (9 * view.frame.width) / 16
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
}

