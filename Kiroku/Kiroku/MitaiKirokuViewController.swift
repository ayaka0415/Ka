//
//  MitaiKirokuViewController.swift
//  Kiroku
//
//  Created by Owner on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import RealmSwift

class MitaiKirokuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedMitai:Mitai!
    var tableView: UITableView?
    var actionType = ""
    //TODO: actionTypeを追加
    //Realm 見たアイテムコレクション
    var mitaiItems:Results<Mitai>!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: viewDidLoad内でアイテムコレクションを定義する
        if self.actionType == "MOVIE" {
            do {
                let realm = try Realm()
                mitaiItems = realm.objects(Mitai.self).filter("cat == 'movie'").sorted(byKeyPath: "createDate",ascending: false)
            } catch {
                print("エラー")
            }
        } else if self.actionType == "BOOK" {
            do {
                let realm = try Realm()
                mitaiItems = realm.objects(Mitai.self).filter("cat == 'book'").sorted(byKeyPath: "createDate",ascending: false)
            } catch {
                print("エラー")
            }
        }
  
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
                tableView.autoresizingMask = [
                    .flexibleWidth,
                    .flexibleHeight
                ]
                
                tableView.delegate = self
                tableView.dataSource = self
                //カスタムセル
                tableView.register (UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"MitaiCell")
                   
                self.view.addSubview(tableView)
                   
                return tableView
            }()
    }
    
      override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //print("MitaiKirokuViewController Will Appear")
            tableView!.reloadData()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            //print("MitaiKirokuViewController Will Disappear")
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return mitaiItems!.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mitaicell = tableView.dequeueReusableCell(withIdentifier: "MitaiCell", for: indexPath) as! TableViewCell

        let mitaiKiroku = mitaiItems?[indexPath.row]
        mitaicell.mitaNamaeLabel.text = mitaiKiroku?.name
        //見たい度を○5で表す
        if mitaiKiroku?.score == "0 点" {
            mitaicell.mitaScoreLabel.text = ""
        } else if mitaiKiroku?.score == "1 点" {
            mitaicell.mitaScoreLabel.text = "●○○○○"
        } else if mitaiKiroku?.score == "2 点" {
            mitaicell.mitaScoreLabel.text = "●●○○○"
        } else if mitaiKiroku?.score == "3 点" {
            mitaicell.mitaScoreLabel.text = "●●●○○"
        } else if mitaiKiroku?.score == "4 点" {
            mitaicell.mitaScoreLabel.text = "●●●●○"
        } else {
            mitaicell.mitaScoreLabel.text = "●●●●●"
        }
        mitaicell.mitaTimeLabel.text = mitaiKiroku?.createDate.description

        return mitaicell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "MitaitoDetail" {
                    let mitai = segue.destination as! KirokuDetailViewController
                    mitai.actionType = self.actionType
                    mitai.selectedMitai = selectedMitai
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //データを次に送る
           self.actionType = "UPDATEMitai"
           selectedMitai = mitaiItems?[indexPath.row]
           self.performSegue(withIdentifier: "MitaitoDetail", sender: selectedMitai)
           }
       
}

