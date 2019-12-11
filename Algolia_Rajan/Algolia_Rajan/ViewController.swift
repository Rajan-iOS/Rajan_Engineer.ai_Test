//
//  ViewController.swift
//  Algolia_Rajan
//
//  Created by PCQ143 on 11/12/19.
//  Copyright © 2019 tatvasoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var FooterView: UIView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl?
    var pageCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        
        //Add Pull to refresh
        self.putToRefreshControl()
    }
    
    func putToRefreshControl() {
        if self.refreshControl == nil {
            refreshControl = UIRefreshControl()
            refreshControl?.attributedTitle = NSAttributedString(string: "Pull To Refresh")
            refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
            self.tblView.addSubview(refreshControl!)
        }
    }
    
    @objc func pullToRefresh() {
        self.pageCount = 0
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

class MyCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var switchToggle: UISwitch!
    
}
