//
//  Record.swift
//  NewProjectTemplate
//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

// NOTE: If you're using Realm, uncomment the code below and subclass `Record` instead of `Object` for your Realm objects. Also remove this files entry from .swiftlint.yml.

//import Foundation
//import HandySwift
//import RealmSwift
//
///// The abstract class for storing any records in Realm. Includes a unique id, creation and update dates.
//class Record: Object {
//    // MARK: - Persisted Instance Properties
//    /// The unique id.
//    dynamic private(set) var id = String(randomWithLength: 16, allowedCharactersType: .alphaNumeric) // swiftlint:disable:this variable_name
//
//    /// The date this record was created.
//    dynamic var createdAt = Date()
//
//    /// The date this record was last udpated.
//    dynamic private(set) var updatedAt = Date()
//
//    // MARK: - Computed Instance Properties
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//
//    // MARK: - Instance Methods
//    func save(_ changes: (() -> Void)? = nil) {
//        let realm = self.realm ?? (try! Realm()) // swiftlint:disable:this force_try
//        try! realm.write { // swiftlint:disable:this force_try
//            changes?()
//
//            updatedAt = Date()
//
//            if self.realm == nil {
//                createdAt = Date()
//                realm.add(self)
//            }
//        }
//    }
//
//    func delete(caller: Record? = nil) {
//        let realm = try! Realm() // swiftlint:disable:this force_try
//        try! realm.write { // swiftlint:disable:this force_try
//            realm.delete(self)
//        }
//    }
//}
