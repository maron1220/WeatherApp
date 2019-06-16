//
//  TableViewController.swift
//  WeatherApp
//
//  Created by 細川聖矢 on 2019/06/15.
//  Copyright © 2019 Seiya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class TableViewController: UITableViewController {
    
    //地域の一覧を入れる関数
    var prefectures: [Pref] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://script.google.com/macros/s/AKfycbyFEiNBHOJcs5pGhh1JuKsK17moh3C6TDHD31Gk01NCPcZcwdcA/exec").responseJSON { (response: DataResponse<Any>) in
            if response.result.isFailure == true {
                self.simpleAlert(title:"通信エラー",message:"通信に失敗しました")
                return
            }
            //valに辞書形式で値が入らない場合､処理を実行する
            guard let val = response.result.value as? [String:Any]else{
                self.simpleAlert(title: "通信エラー", message: "通信結果がJSONではありませんでした")
                return
            }
            
            //swifty jsonを使う
            //guardの外でもvalが使える
            let json = JSON(val)
            
            //["rss"]の中の["channel"]の中の["source"]の中の["pref"]の値をとってくる
            let prefJSON = json["rss"]["channel"]["source"]["pref"].arrayValue
            self.prefectures = prefJSON.map { item in
                return Pref(pref: item)
            }
            // テーブルにデータを反映
            self.tableView.reloadData()
        }
    }
    
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return prefectures.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //セクションごとの列の数を返す関数です。今回は都道府県ごとにセクションを分け、その中に市区町村の地域名を表示しますので、prefectures内の各要素の中にあるcitiesの要素数を指定します。
        let cities = prefectures[section].cities
        
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return prefectures[section].title //section番目のタイトルを取得する
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prefCell", for: indexPath) as! TableViewCell
        
        //indexPath.section=セクションの何番目か｡
        //cities[indexPath.row]=citiesの何番目か
        cell.titleLabel.text = prefectures[indexPath.section].cities[indexPath.row].title
        
        cell.idLabel.text = prefectures[indexPath.section].cities[indexPath.row].id
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController{
            /*押されたセルの情報がsenderに入る*/
            if let cell = sender as? TableViewCell , let indexPath = tableView.indexPath(for:cell){
                //prefectureの中のcitiesの中のidを取得
                detailVC.cityID = prefectures[indexPath.section].cities[indexPath.row].id
            }
        }
    }
    
}
