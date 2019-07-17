//
//  PreviewViewController.swift
//  Project Thirteen
//
//  Created by Alex Pilcher on 16/07/2019.
//  Copyright © 2019 Alex Pilcher. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func retakeButton(_ sender: Any) {
        performSegue(withIdentifier: "retakeSegue", sender: nil)
    }
    
    @IBAction func useButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = self.image
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
