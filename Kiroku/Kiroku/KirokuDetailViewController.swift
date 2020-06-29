//
//  KirokuDetailViewController.swift
//  Kiroku
//
//  Created by Owner on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import RealmSwift

class KirokuDetailViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var catSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tensuLabel: UILabel!
    @IBOutlet weak var MitaButton: UIButton!
    
    
    var actionType = ""
    var selectedMita:Mita!
    var selectedMitai:Mitai!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView(){
        //見た(追加・編集)
        if actionType == "NEWMita" {
            self.title = "見たを追加"
            self.commitButton.setTitle("追加", for: .normal)
            self.commitButton.addTarget(self, action: "dbAdd:", for: .touchUpInside)
            self.nameField.text = ""
            self.descTextView.text = ""
            self.navigationItem.rightBarButtonItem = nil
            self.MitaButton.isHidden = true
            ///
           if actionType == "BOOK" {
                           self.catSegmentedControl.selectedSegmentIndex = 1;
                      }
            ///
        } else if actionType == "UPDATEMita" {
            self.title = "見たを編集"
            self.commitButton.setTitle("更新", for: .normal)
            self.commitButton.addTarget(self, action: "dbUpdate:", for: .touchUpInside)
            self.nameField.text = selectedMita.name
            self.descTextView.text = selectedMita.desc
            self.scoreLabel.text = selectedMita.score
            self.MitaButton.isHidden = true
            
        //見たい(追加・編集)
        } else if actionType == "NEWMitai" {
            self.title = "見たいを追加"
            self.commitButton.setTitle("追加", for: .normal)
            self.commitButton.addTarget(self, action: "dbAdd:", for: .touchUpInside)
            self.nameField.text = ""
            self.descTextView.text = ""
            self.navigationItem.rightBarButtonItem = nil
            self.tensuLabel.text = "見たい度"
            self.MitaButton.isHidden = true
            
        } else if actionType == "UPDATEMitai" {
            self.title = "見たいを編集"
            self.commitButton.setTitle("更新", for: .normal)
            self.commitButton.addTarget(self, action: "dbUpdate:", for: .touchUpInside)
            self.nameField.text = selectedMitai.name
            self.descTextView.text = selectedMitai.desc
            self.scoreLabel.text = selectedMitai.score
            self.tensuLabel.text = "見たい度or点数"
        }
    }
    
    //点数・見たい度Sliderの設定
    @IBAction func scoreSlider(_ sender: UISlider) {
        let scoreSlider: Int = Int(sender.value)
        scoreLabel.text =  String(format:"%d 点%", scoreSlider)
    }

    //DB登録
    @IBAction func dbAdd(_ sender: AnyObject) {
        //入力チェック
        if isValidateInputContents() == false{
            return
        }
        
        if actionType == "NEWMita" {
        //カテゴリー映画選択(見た)
        if catSegmentedControl.selectedSegmentIndex == 0 {
            
            let mita = Mita()
            mita.desc = descTextView.text
            mita.name = nameField.text!
            mita.cat = "movie"
            mita.score = scoreLabel.text!
        
            mita.createDate = NSDate()
            
            //DB登録
            do {
                let realm = try Realm()
                
                //DB中身確認
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                
                
                try realm.write{
                    realm.add(mita)
                }
                print("登録成功")
            }catch{
                print("登録失敗")
            }
            //前の画面戻る
            self.navigationController?.popViewController(animated: true)
        //カテゴリー本を選択(見た)
        } else if catSegmentedControl.selectedSegmentIndex == 1 {
       
            let mita = Mita()
            mita.desc = descTextView.text
            mita.name = nameField.text!
            mita.cat = "book"
            mita.score = scoreLabel.text!
            
            mita.createDate = NSDate()
            
            do{
                let realm = try Realm()
                try realm.write{
                    realm.add(mita)
                }
                print("成功")
            }catch{
                print("失敗")
            }
            self.navigationController?.popViewController(animated: true)
        }
        } else if actionType == "NEWMitai" {
            //カテゴリー映画を選択(見たい)
            if catSegmentedControl.selectedSegmentIndex == 0 {
                 
                let mitai = Mitai()
                mitai.desc = descTextView.text
                mitai.name = nameField.text!
                mitai.cat = "movie"
                mitai.score = scoreLabel.text!
             
                mitai.createDate = NSDate()
                 
                //DB登録
                do {
                    let realm = try Realm()
                     
                    //DB中身確認
                    print(Realm.Configuration.defaultConfiguration.fileURL!)
                     
                     
                    try realm.write{
                        realm.add(mitai)
                    }
                    print("登録成功")
                }catch{
                    print("登録失敗")
                }
                //前の画面戻る
                self.navigationController?.popViewController(animated: true)
            // カテゴリー本を選択(見たい)
             } else if catSegmentedControl.selectedSegmentIndex == 1 {
            
                 let mitai = Mitai()
                 mitai.desc = descTextView.text
                 mitai.name = nameField.text!
                 mitai.cat = "book"
                 mitai.score = scoreLabel.text!
                 
                 mitai.createDate = NSDate()
                 
                 do{
                     let realm = try Realm()
                     try realm.write{
                         realm.add(mitai)
                     }
                     print("成功")
                 }catch{
                     print("失敗")
                 }
                 self.navigationController?.popViewController(animated: true)
             }
        
        }
        
    }
    
    //入力チェック
    private func isValidateInputContents() -> Bool{
        //名前の入力
        if let name = nameField.text{
            if name.count == 0{
                return false
            }
        }else{
            return false
        }
        return true
    }
    
    //DB更新
    @IBAction func dbUpdate(_ sender: AnyObject) {
    
        if actionType == "UPDATEMita" {
            
                do{
                    let realm = try Realm()
                    try realm.write{
                        selectedMita.name = self.nameField.text!
                        selectedMita.desc = self.descTextView.text
                        selectedMita.updateDate = NSDate()
                        selectedMita.score = self.scoreLabel.text!
                        //カテゴリーの変更
                        if catSegmentedControl.selectedSegmentIndex == 0 {
                            selectedMita.cat = "movie"
                        }else if catSegmentedControl.selectedSegmentIndex == 1 {
                            selectedMita.cat = "book"
                        }
                    }
                    print("見たDB更新成功")
                }catch{
                    print("見たDB更新失敗")
                }
                self.navigationController?.popViewController(animated: true)
        } else if actionType == "UPDATEMitai" {
            
            do {
                let realm = try Realm()
                try realm.write{
                    selectedMitai.name = self.nameField.text!
                    selectedMitai.desc = self.descTextView.text
                    selectedMitai.updateDate = NSDate()
                    selectedMitai.score = self.scoreLabel.text!
                    //カテゴリーの変更
                    if catSegmentedControl.selectedSegmentIndex == 0 {
                        selectedMitai.cat = "movie"
                    }else if catSegmentedControl.selectedSegmentIndex == 1 {
                        selectedMitai.cat = "book"
                    }
                }
                print("見たDB更新成功")
            } catch {
                print("見たDB更新失敗")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    //削除
    @IBAction func dbDelete(_ sender: AnyObject) {
        if actionType == "UPDATEMita" {
        do {
            let realm = try Realm()
            try realm.write{
                realm.delete(selectedMita)
            }
        } catch {
            print("失敗")
        }
        self.navigationController?.popViewController(animated: true)
        } else if actionType == "UPDATEMitai" {
        do {
            let realm = try Realm()
            try realm.write{
            realm.delete(selectedMitai)
            }
        } catch {
            print("失敗")
        }
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func MitaButton(_ sender: Any) {
     if catSegmentedControl.selectedSegmentIndex == 0 {
             
             let mita = Mita()
             mita.desc = descTextView.text
             mita.name = nameField.text!
             mita.cat = "movie"
             mita.score = scoreLabel.text!
         
             mita.createDate = NSDate()
             
             //DB登録
             do {
                 let realm = try Realm()
                 
                 //DB中身確認
                 print(Realm.Configuration.defaultConfiguration.fileURL!)
                 
                 
                 try realm.write{
                     realm.add(mita)
                 }
                 print("登録成功")
             }catch{
                 print("登録失敗")
             }
        //アラート
        let alert = UIAlertController(title: "見たに追加しました", message: "右上の削除ボタンを押してください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) -> Void in
        
        }))
            self.present(alert, animated: true, completion: nil)
         //カテゴリー本を選択(見た)
         } else if catSegmentedControl.selectedSegmentIndex == 1 {
        
             let mita = Mita()
             mita.desc = descTextView.text
             mita.name = nameField.text!
             mita.cat = "book"
             mita.score = scoreLabel.text!
             
             mita.createDate = NSDate()
             
             do{
                 let realm = try Realm()
                 try realm.write{
                     realm.add(mita)
                 }
                print("成功")
             }catch{
                 print("失敗")
             }
        //アラート
        let alert = UIAlertController(title: "見たに追加しました", message: "右上の削除ボタンを押してください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction) -> Void in
        
        }))
            self.present(alert, animated: true, completion: nil)
         }
    }
    //UITextField等そこ以外の部分をタッチするとキーボード閉じる
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
