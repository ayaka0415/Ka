//
//  KirokuViewController.swift
//  Kiroku
//
//  Created by Owner on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import RealmSwift

class KirokuViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var actionType = ""
    
    
    private lazy var MitaKirokuViewController: MitaKirokuViewController = {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyborad.instantiateViewController(identifier: "MitaKirokuViewController") as! MitaKirokuViewController
        viewController.actionType = self.actionType
        add(asChildViewController: viewController)
        return viewController
    } ()
    
    private lazy var MitaiKirokuViewController: MitaiKirokuViewController = {
      
        let  storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        var  viewController = storyborad.instantiateViewController(identifier: "MitaiKirokuViewController") as! MitaiKirokuViewController
        viewController.actionType = self.actionType
        add(asChildViewController: viewController)
        return viewController
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: MitaiKirokuViewController)
            add(asChildViewController: MitaKirokuViewController)
            
        } else {
            remove(asChildViewController: MitaKirokuViewController)
            add(asChildViewController: MitaiKirokuViewController)
            
        }
    }

    
    @IBAction func segmentValueChanged(_ sender: Any) {
        updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        //子ViewControllerを追加
        addChild(viewController)
        // Subviewとして子ViewControllerのViewを追加
        view.addSubview(viewController.view)
        //設定
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //通知
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        //子View Controllerへの通知
        viewController.willMove(toParent: nil)
        //子ViewをSuperviewから削除
        viewController.view.removeFromSuperview()
        //通知
        viewController.removeFromParent()
    }
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {
        
         if segmentedControl.selectedSegmentIndex == 0 {
            self.actionType = "NEWMita"
            self.performSegue(withIdentifier: "toDetail", sender: nil)
            
         }else{
            self.actionType = "NEWMitai"
            self.performSegue(withIdentifier: "toDetail", sender: nil)
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail" {
                let vc = segue.destination as! KirokuDetailViewController
                vc.actionType = self.actionType
        }
    }
}
