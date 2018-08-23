//
//  Realm.swift
//  Ara!Gohan
//
//  Created by YOSUKE on 2018/08/23.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object {
    //Realmクラスのインスタンス
    static let realm = try! Realm()
    //id
    @objc dynamic var id = 0
    @objc dynamic var tabelog_url = ""
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var pref = ""
    //    @objc dynamic var zip = ""
    @objc dynamic var tel = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude:Double = 0.0
    @objc dynamic var price = ""
    @objc dynamic var category = ""
    @objc dynamic var rate : Float = 0.0
    @objc dynamic var moyori = ""
    @objc dynamic var transportation = ""
    @objc dynamic var hours = ""
    @objc dynamic var holiday = ""
    @objc dynamic var website = ""
    @objc dynamic var favorite = false
    @objc dynamic var googleID = ""
    
    
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    //Create新規追加用インスタンス生成メソッド
    static func create() -> Restaurant {
        let res = Restaurant()
        res.id = lastId()
        
        //        if shop.id == 0 {
        //            shop.id = 2
        //        }
        return res
        
    }
    //インスタンス保存用のメソッド
    func save() {
        try! Restaurant.realm.write {
            Restaurant.realm.add(self)
        }
    }
    //インスタンス削除用メソッド
    func delete() {
        try! Restaurant.realm.write {
            Restaurant.realm.delete(self)
        }
    }
    //プライマリーキー作成メソッドlastID
    static func lastId() -> Int {
        if let res = realm.objects(Restaurant.self).sorted(byKeyPath: "id").last {
            return res.id + 1
        }else {
            return 1
        }
    }
    //loadAll（順番はわからん読み込み順。並び替えしてない）
    static func loadAll() -> [Restaurant] {
        let ress = realm.objects(Restaurant.self)
        var resList: [Restaurant] = []
        for res in ress {
            resList.append(res)
        }
        return resList
    }
}


class Favorite: Object {
    //Realmクラスのインスタンス
    static let realm = try! Realm()
    //id
    @objc dynamic var id = 0
    @objc dynamic var favorite: Restaurant?
    @objc dynamic var memo:String = ""
    
    
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    //Create新規追加用インスタンス生成メソッド
    static func create() -> Favorite {
        let favorite = Favorite()
        favorite.id = lastId()
        return favorite
    }
    
    //インスタンス保存用のメソッド
    func save() {
        try! Favorite.realm.write {
            Favorite.realm.add(self)
        }
    }
    //インスタンス削除用メソッド
    func delete() {
        try! Favorite.realm.write {
            Favorite.realm.delete(self)
        }
    }
    //プライマリーキー作成メソッドlastID
    static func lastId() -> Int {
        if let favorite = realm.objects(Favorite.self).sorted(byKeyPath: "id").last {
            return favorite.id + 1
        }else {
            return 1
        }
    }
    //loadAll（順番はわからん読み込み順。並び替えしてない）
    static func loadAll() -> [Favorite] {
        let favorites = realm.objects(Favorite.self)
        var favoriteList: [Favorite] = []
        for favorite in favorites {
            favoriteList.append(favorite)
        }
        return favoriteList
    }
}

