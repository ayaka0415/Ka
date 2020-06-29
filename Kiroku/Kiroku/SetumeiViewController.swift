//
//  SetumeiViewController.swift
//  Kiroku
//
//  Created by Owner on 2020/06/29.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class SetumeiViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var onNext: UIButton!
    @IBOutlet weak var onPrev: UIButton!
    
    var dispImageNo = 0
    
    @IBAction func onPrev(_ sender: Any) {
        // 表示している画像の番号を1減らす
        dispImageNo -= 1
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    @IBAction func onNext(_ sender: Any) {
        
        dispImageNo += 1
        displayImage()
      
    }
    
    /// 表示している画像の番号を元に画像を表示する
    func displayImage() {

        // 画像の名前の配列
        let imageNameArray = [
            "Top",
            "MitaMitaiList",
            "Edit",
        ]
        // 画像の番号が正常な範囲を指しているかチェック
        // 範囲より下を指している場合、最後の画像を表示
        if dispImageNo < 0 {
            dispImageNo = 2
        }
        // 範囲より上を指している場合、最初の画像を表示
        if dispImageNo > 2 {
            dispImageNo = 0
        }
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[dispImageNo]

        // 画像を読み込み
        let image = UIImage(named: name)

        // Image Viewに読み込んだ画像をセット
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Top")
        imageView.image = image
    }
  
}
