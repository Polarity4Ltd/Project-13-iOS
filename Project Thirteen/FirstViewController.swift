//
//  FirstViewController.swift
//  Project Thirteen
//
//  Created by Alex Pilcher on 15/07/2019.
//  Copyright © 2019 Alex Pilcher. All rights reserved.
//

import UIKit

struct cellData{
    let cell : Int!
    let companyNameVar : String!
    let time : String!
    let type : String!
    let msgContent : String!
}

class newsFeedItems: Codable{
    let index: Int!
    let title: String!
    let text: String!
    let dateTime: String!
}
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [cellData]()
    var companyName = "Thirteen Group"
    var messageType = "Customer Notification"
    var msgContent = "Your payment of £375.00 has been authorised."
    var timeStamp = "01/10/2019"
    
    func jsonFile(){
        let url = URL(string: "https://polarity4services.azurewebsites.net/api/newsfeed/1")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
        if error != nil{
            print(error!)
        } else {
            if let content = data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
                        
                        var dict = Dictionary<String, Any>()
                        dict = json
                        print(dict)
                        
                        let decoder = JSONDecoder()
                        let feedData = try! decoder.decode(newsFeedItems.self, from: content)
                        
                        print(feedData.text)
                    }
                }
                catch {
                }
            }
        }
    }
        task.resume()
    }
    
    
    func createFeed(dictionary : NSDictionary){
        //let valuesArray = dictionary.allValues
        print(dictionary)
        
        for (key,value) in dictionary {
            print("current key:\(key) value:\(value as! String)")
        }
        
    }
    
    func caughtValues(companyName: String, messageTypeLabel: String, contentLabel: String){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [cellData(cell: 1, companyNameVar: companyName, time: timeStamp, type: messageType, msgContent: msgContent)]
        print(jsonFile())
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = Bundle.main.loadNibNamed("TableViewCell1TableViewCell", owner: self, options: nil)?.first as! TableViewCell1TableViewCell
        
        cell.companyLabel.text = data[indexPath.row].companyNameVar
        cell.timeLabel.text = data[indexPath.row].time
        cell.messageTypeLabel.text = data[indexPath.row].type
        cell.contentLabel.text = data[indexPath.row].msgContent
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

