//
//  MitaKirokuViewController.swift
//  Kiroku
//
//  Created by Owner on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import RealmSwift

class MitaKirokuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedMita:Mita!
    var tableView: UITableView?
    var actionType:String = ""
    
    //Realm 見たアイテムコレクション
    var mitaItems:Results<Mita>!


    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: viewDidLoad内でアイテムコレクションを定義する
        // TODO: ここでactionTypeによってデータベースから持ってくる値をif文
        if self.actionType == "MOVIE" {
            do {
                let realm = try Realm()
                mitaItems = realm.objects(Mita.self).filter("cat == 'movie'").sorted(byKeyPath: "createDate",ascending: false)
            } catch {
                print("エラー")
            }
            
        } else if self.actionType == "BOOK" {
                do {
                    let realm = try Realm()
                    mitaItems = realm.objects(Mita.self).filter("cat == 'book'").sorted(byKeyPath: "createDate",ascending: false)
                    print("self.actionType: \(self.actionType)")
                } catch {
                    print("mitaエラー")
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
            tableView.register (UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"MitaCell")
            
            self.view.addSubview(tableView)
            
            return tableView
            
        }()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        tableView!.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mitaItems!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得
        let mitacell = tableView.dequeueReusableCell(withIdentifier: "MitaCell", for: indexPath) as! TableViewCell

        let mitaKiroku = mitaItems?[indexPath.row]

        mitacell.mitaNamaeLabel.text = mitaKiroku?.name
        //点数を☆5で表す
        if mitaKiroku?.score == "0 点" {
            mitacell.mitaScoreLabel.text = "0点"
        } else if mitaKiroku?.score == "1 点" {
            mitacell.mitaScoreLabel.text = "★☆☆☆☆"
        } else if mitaKiroku?.score == "2 点" {
            mitacell.mitaScoreLabel.text = "★★☆☆☆"
        } else if mitaKiroku?.score == "3 点" {
            mitacell.mitaScoreLabel.text = "★★★☆☆"
        } else if mitaKiroku?.score == "4 点" {
            mitacell.mitaScoreLabel.text = "★★★★☆"
        } else {
            mitacell.mitaScoreLabel.text = "★★★★★"
        }
        
        mitacell.mitaTimeLabel.text = mitaKiroku?.createDate.description
//        mitacell.mitaTimeLabel.text = mitaKiroku?.createDate.description
//        var test_date = mitaKiroku?.createDate.description
//        print(type(of: test_date))
      
        
        return mitacell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "MitatoDetail" {
                let mita = segue.destination as! KirokuDetailViewController
                mita.actionType = self.actionType
                mita.selectedMita = selectedMita

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //データを次に送る
        self.actionType = "UPDATEMita"
        selectedMita = mitaItems?[indexPath.row]
        self.performSegue(withIdentifier: "MitatoDetail", sender: selectedMita)
        if actionType == "BOOK"{
            self.actionType = "BOOK"
        }
        }
    
}

