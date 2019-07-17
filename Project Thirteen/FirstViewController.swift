//
//  FirstViewController.swift
//  Project Thirteen
//
//  Created by Alex Pilcher on 15/07/2019.
//  Copyright © 2019 Alex Pilcher. All rights reserved.
//

import UIKit
import Foundation

struct CellDataList: Decodable{
    var newsfeedList: [cellData]
}

struct cellData: Decodable{
    var index : Int?
    var title : String?
    var text : String?
    var dateCreated : String?
    
    init(index:Int, title:String, text:String, dateCreated:String)
    {
        self.index = index
        self.title = title
        self.text = text
        self.dateCreated = dateCreated
    }
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var newsFeedData = [cellData]()
    var myData: CellDataList?
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(FirstViewController.refreshTable), for: UIControl.Event.valueChanged)
        loadDataFromService()
        tableView.addSubview(refresher)
        
        refreshTable()

    }
    
    func loadDataFromService(){
        let jsonUrlString = "https://polarity4services.azurewebsites.net/api/newsfeed/1"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let feedItem = try JSONDecoder().decode(CellDataList.self, from: data)
                
                for listItem in feedItem.newsfeedList{
                    
                    let tempCell = cellData(index: listItem.index!, title: listItem.title!, text: listItem.text!, dateCreated: listItem.dateCreated!)
                
                    self.newsFeedData.append(tempCell)
                }
                
                
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        while (newsFeedData == nil){
            print("sleep for 1.000 seconds.")
            sleep(UInt32(1.000)) // not working
        }
        
        print(newsFeedData[0].text!)
        
        
            let cell = Bundle.main.loadNibNamed("TableViewCell1TableViewCell", owner: self, options: nil)?.first as! TableViewCell1TableViewCell
        
        let timeTruncated = newsFeedData[indexPath.row].dateCreated
        let timeArray = timeTruncated?.components(separatedBy:"T")
        
        print(timeArray!)
        
        cell.companyLabel.text = newsFeedData[indexPath.row].title
        cell.timeLabel.text = newsFeedData[indexPath.row].dateCreated
        cell.contentLabel.text = newsFeedData[indexPath.row].text
            return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            newsFeedData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func refreshTable(){
        refresher.endRefreshing()
        tableView.reloadData()
    }
}

