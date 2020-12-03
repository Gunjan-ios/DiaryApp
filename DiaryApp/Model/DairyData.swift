//
//  DairyDataRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 3, 2020

import Foundation
import SwiftyJSON


class DiaryData : NSObject, NSCoding{

    var content : String!
    var date : String!
    var id : String!
    var title : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        content = json["content"].stringValue
        date = json["date"].stringValue
        id = json["id"].stringValue
        title = json["title"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if content != nil{
        	dictionary["content"] = content
        }
        if date != nil{
        	dictionary["date"] = date
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if title != nil{
        	dictionary["title"] = title
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		content = aDecoder.decodeObject(forKey: "content") as? String
		date = aDecoder.decodeObject(forKey: "date") as? String
		id = aDecoder.decodeObject(forKey: "id") as? String
		title = aDecoder.decodeObject(forKey: "title") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
