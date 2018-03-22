//
//  DetailViewController.swift
//  adjaranet-ios
//
//  Created by Irakli Tchitadze on 3/6/18.
//  Copyright © 2018 Buglinjo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var expandArrow: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var seasonPickerView: UIPickerView!
    @IBOutlet weak var qualityButton: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    var headerView = UIView()
    var initialHeaderHeight: CGFloat!
    var headerHeight: CGFloat!
    let maxStretch: CGFloat = 140
    
    var footerView = UIView()
    var footerHeight: CGFloat = 0
    
    var tableViewHeight: CGFloat?
    
    var expandArrowAlpha: CGFloat = 0.75
    
    var heightDelta: CGFloat = 100
    
    let pickerDataSource = ["სეზონი 1", "სეზონი 2", "სეზონი 3", "სეზონი 4", "სეზონი 5"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    func setupLayout() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        closeButton.dropShadow(color: .black, opacity: 0.2, offset: CGSize.zero, radius: 3)
        imageView.dropShadow(color: .black, opacity: 1, offset: CGSize.zero, radius: 20)
        shadowView.dropShadow(color: .black, opacity: 1, offset: CGSize.zero, radius: 8)
        expandArrow.dropShadow(color: .black, opacity: 1, offset: CGSize.zero, radius: 10)
        playButton.dropShadow(color: .black, opacity: 0.4, offset: CGSize.zero, radius: 8)
        
        seasonPickerView.delegate = self
        seasonPickerView.dataSource = self
        
        playButton.layer.cornerRadius = 5
        
        let downloadIcon = UIImage(named: "download")?.withRenderingMode(.alwaysTemplate)
        
        downloadButton.setImage(downloadIcon, for: .normal)
        downloadButton.tintColor = .white
        
        expandArrow.alpha = expandArrowAlpha
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        if let headerView = tableView.tableHeaderView {
            self.headerView = headerView
            tableView.tableHeaderView = nil
            tableView.addSubview(headerView)
        }
        
        if let footerView = tableView.tableFooterView {
            self.footerView = footerView
            tableView.tableFooterView = nil
            tableView.addSubview(footerView)
        }
        
        initialHeaderHeight = view.frame.height + heightDelta
        
        setupHeaderView()
    }
    
    func setupHeaderView() {
        headerHeight = initialHeaderHeight
        
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: footerHeight, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -headerHeight)
        
        tableViewHeight = tableView.contentSize.height
    }
    
    @objc func dismissView() {
        UIApplication.shared.statusBarStyle = .default
        self.dismiss(animated: true, completion: nil)
    }
    
    func slideDownView() {
        let transition: CATransition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        UIApplication.shared.statusBarStyle = .default
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsEpisodeTableViewCellId", for: indexPath) as! DetailsEpisodeTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerDataSource[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [
            NSAttributedStringKey.font: UIFont(name: "DejaVu Sans", size: 17)!,
            NSAttributedStringKey.foregroundColor: UIColor.white
            ])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataSource[row])
    }
    
    func stretchyScroll() {
        var headerRect = CGRect(x: 0, y: -headerHeight, width: tableView.frame.width, height: headerHeight)
        
        var tableViewHeightLocal = CGFloat()
        
        if let tvh = tableViewHeight {
            tableViewHeightLocal = tvh
        }
        
        var footerRect = CGRect(x: 0, y: headerHeight + tableViewHeightLocal + heightDelta, width: tableView.frame.width, height: footerHeight)
        
        expandArrow.alpha = expandArrowAlpha - ((tableView.contentOffset.y + view.frame.height) / 100)
        
        if tableView.contentOffset.y < -headerHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
            
            let stretchAmount = -(tableView.contentOffset.y + initialHeaderHeight)
            
            closeButton.alpha = (1 - (stretchAmount / maxStretch))
            
            if (tableView.contentOffset.y < -(initialHeaderHeight + maxStretch)) {
                slideDownView()
            }
        } else if tableView.contentOffset.y > tableViewHeightLocal - (tableView.frame.height + heightDelta) {
            footerRect.origin.y = tableViewHeightLocal + heightDelta
            footerRect.size.height = tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
        footerView.frame = footerRect
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        stretchyScroll()
    }
    
    override func viewDidLayoutSubviews() {
        stretchyScroll()
        self.tableView.reloadData()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        initialHeaderHeight = view.frame.width + heightDelta
        setupHeaderView()
        self.tableView.reloadData()
    }
    
}
