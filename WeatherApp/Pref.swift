//
//  Pref.swift
//  WeatherApp
//
//  Created by 細川聖矢 on 2019/06/15.
//  Copyright © 2019 Seiya. All rights reserved.
//

import Foundation
import SwiftyJSON

class Pref{
    let title:String
    let cities:[City]
    
    init(pref: JSON){
        title = pref["title"].stringValue
        //sitiesは配列で返ってくるので､mapで配列全てに行う処理を書いている
        cities = pref["city"].arrayValue.map({item in
            return City(city:item)
        })
    }
}







