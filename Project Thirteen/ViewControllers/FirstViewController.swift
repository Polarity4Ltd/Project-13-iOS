//
//  FirstViewController.swift
//  Project Thirteen
//
//  Created by Alex Pilcher on 15/07/2019.
//  Copyright © 2019 Alex Pilcher. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = ["one","two","three"]
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Bundle.main.loadNibNamed("TableViewCell1TableViewCell", owner: self, options: nil)?.first as! TableViewCell1TableViewCell
        
            cell.companyLabel.text = data[indexPath.row].text
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

