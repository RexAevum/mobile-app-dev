//
//  ViewController.swift
//  PA1_Qestions
//
//  Created by Rolans Apinis on 5/15/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //connect labels
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var nr: UILabel!
    
    //set up questions using array
    let questions: [String] = [
    "What is the capital of Latvia?",
    "The fear of Halloween is called"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //add actions to buttons
    @IBAction func iKnow(_ sender: Any) {
    }
    
    @IBAction func iGiveUp(_ sender: Any) {
    }
    
    
    
}

