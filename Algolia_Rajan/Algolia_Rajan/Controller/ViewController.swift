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
    var postArray:[AlgoliaPostDetail] = []
    var pageCount: Int = 0
    var isPageCompleted: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        
        //Set Navigation Title
        self.setNavigationTitle()
        
        //Add Pull to refresh
        self.putToRefreshControl()
    }
    
    func setTitle()  {
        let arrFilter = self.postArray.filter { (post) -> Bool in
            return post.isPostSelected
        }
        if arrFilter.count == 0 {
            self.title = "Number Of Selected Posts: 0"
        } else {
            self.title = arrFilter.count > 1 ? "Number Of Selected Posts: " + "\(arrFilter.count)" : "Number Of Selected Post: " + "\(arrFilter.count)"
        }
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
    
    func callPostAPI() {
    
        let serviceURL = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=" + "\(self.pageCount)"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(serviceURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch(response.result) {
            case .success(let value):
                let json = JSON(value)
                
                if self.pageCount == 0 {
                    self.refreshControl?.endRefreshing()
                    self.postArray.removeAll()
                    self.setTitle()
                }
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        let postList: Array<JSON> = json["hits"].arrayValue
                        let totalCount = json["nbPages"].intValue
                        
                        if self.pageCount < totalCount {
                            self.isPageCompleted = false
                            for i in 0..<postList.count {
                                //If not a Dictionary or nil, return [:]
                                let dictPost = JSON(postList[i].dictionaryValue)
                                let post = AlgoliaPostDetail.init(dictionary: dictPost)
                                self.postArray.append(post)
                            }
                            self.ActivityIndicator.stopAnimating()
                        } else {
                            self.isPageCompleted = true
                        }
                        
                        self.tblView.reloadData()
                        break
                    default:
                        break
                    }
                }
                break
            case .failure:
                print("Fail")
                self.refreshControl?.endRefreshing()
                break
            }
        }
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
    
    static let cellIdentifier = "MyCell"
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var switchToggle: UISwitch!
    
}
