//
//  City.swift
//  WeatherApp
//
//  Created by 細川聖矢 on 2019/06/15.
//  Copyright © 2019 Seiya. All rights reserved.
//

import Foundation
import SwiftyJSON

class City {
    let id:String //ID
    let title:String //市区町村名
    
    //初期化のための関数
    //今回は引数にJSONを使用
    //クラスにどんな値がはいって来るかを定義している
    init(city: JSON) {
        id = city["id"].stringValue
        title = city["title"].stringValue
    }
}
