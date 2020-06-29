//
//  Kiroku.swift
//  Kiroku
//
//  Created by Owner on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import Foundation
import RealmSwift

class Mita: Object{
    //タイトル名
    @objc dynamic var name = ""
    //カテゴリー
    @objc dynamic var cat = ""
    //説明文
    @objc dynamic var desc = ""
    //完了フラグ
    @objc dynamic var isComplete = false
    //作成日
    @objc dynamic var createDate = NSDate(timeIntervalSince1970: 0)
    //更新日
    @objc dynamic var updateDate = NSDate(timeIntervalSince1970: 0)
    //点数
    @objc dynamic var score = ""

}

class Mitai: Object{
    //タイトル名
    @objc dynamic var name = ""
    //カテゴリー
    @objc dynamic var cat = ""
    //説明文
    @objc dynamic var desc = ""
    //完了フラグ
    @objc dynamic var isComplete = false
    //作成日
    
    @objc dynamic var createDate = NSDate(timeIntervalSince1970: 0)
    //更新日
    @objc dynamic var updateDate = NSDate(timeIntervalSince1970: 0)
    //点数
    @objc dynamic var score = ""
}
