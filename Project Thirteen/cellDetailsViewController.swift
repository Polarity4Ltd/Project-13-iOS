//
//  cellDetailsViewController.swift
//  Project Thirteen
//
//  Created by Alex Pilcher on 17/07/2019.
//  Copyright © 2019 Alex Pilcher. All rights reserved.
//

import UIKit

class cellDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var cellTitle: String = ""
    var cellText: String = ""
    var cellDateCreated: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = cellTitle
        contentLabel.text = cellText
        dateTimeLabel.text = cellDateCreated
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
