//
//  AlgoliaPostDetail.swift
//  
//
//  Created by PCQ143 on 11/12/19.
//

import UIKit
import SwiftyJSON

class AlgoliaPostDetail: NSObject {

    var title                  : String! = ""
    var created_at             : String! = ""
    var isPostSelected         : Bool = false
    
    
    required init(dictionary: JSON) {
        if dictionary.isEmpty != true {
            self.title = dictionary["title"].stringValue
            if let createdAt = dictionary["created_at"].string {
                let date = PostDate.date(fromString: createdAt, withFormat: PostDateFormat.serverDateFormat)
                self.created_at = PostDate.string(fromDate: date!, withFormat: PostDateFormat.appDateFormat)
            }
        }
    }
}
