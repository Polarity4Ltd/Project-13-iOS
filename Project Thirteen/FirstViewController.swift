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
    var dataLoaded = 0

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
            
            DispatchQueue.main.async { self.tableView.reloadData() }
            
            }.resume()
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = Bundle.main.loadNibNamed("TableViewCell1TableViewCell", owner: self, options: nil)?.first as! TableViewCell1TableViewCell
        
        let timeTruncated = newsFeedData[indexPath.row].dateCreated
        let timeArray = timeTruncated?.components(separatedBy:"T")
        
        let time = String(timeArray![1]).prefix(5)
        
        
        cell.companyLabel.text = newsFeedData[indexPath.row].title
        cell.timeLabel.text = String((timeArray?[0])!) + " at " + time
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! cellDetailsViewController
        let indexRow = tableView.indexPathForSelectedRow!
        VC.cellTitle = newsFeedData[indexRow[1]].title!
        VC.cellText = newsFeedData[indexRow[1]].text!
        VC.cellDateCreated = newsFeedData[indexRow[1]].dateCreated!
        
        //ViewController.cellValues = [newsFeedData[indexRow[1]].title!,newsFeedData[indexRow[1]].text!,newsFeedData[indexRow[2]].dateCreated!]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pressCellSegue", sender: nil)
    }
    
    @objc func refreshTable(){
        refresher.endRefreshing()
        tableView.reloadData()
    }
}

