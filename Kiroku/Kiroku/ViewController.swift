//
//  ViewController.swift
//  Kiroku
//
//  Created by Owner on 2020/06/19.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var actionType = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func MovieButton(_ sender: Any) {
       
        self.performSegue(withIdentifier: "toMovieKiroku", sender: nil)
    }
    
    @IBAction func BookButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toBookKiroku", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookKiroku" {
            self.actionType = "BOOK"
            let toBookVC = segue.destination as! KirokuViewController
            toBookVC.actionType = self.actionType
        } else if segue.identifier == "toMovieKiroku" {
            self.actionType = "MOVIE"
            let toMovieVC = segue.destination as! KirokuViewController
            toMovieVC.actionType = self.actionType
        }

    }
}
