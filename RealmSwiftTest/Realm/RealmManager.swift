//
//  RealmManager.swift
//  RealmSwiftTest
//
//  Created by Jiny on 2023/11/02.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    let config = Realm.Configuration(schemaVersion: 0)

    func getRootModelObject(forKey key: String) -> RootModelObject? {
        do {
            let realm = try Realm()
            return realm.object(ofType: RootModelObject.self, forPrimaryKey: key)
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

    func getObjects() -> Results<RootModelObject>? {
        do {
            let realm = try Realm()
            return realm.objects(RootModelObject.self)
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

    func isKeyAlreadyExists(key: String) -> Bool {
        return getRootModelObject(forKey: key) != nil
    }

    func writeRootModelObject(forKey key: String, tasks: [SomeModelObject]) {
        do {
            let realm = try Realm()
            if let existingObject = getRootModelObject(forKey: key) {
                try realm.write {
                    for task in tasks {
                        existingObject.tasks.append(task)
                    }
                }
            } else {
                let rootObject = RootModelObject(key: key, tasks: tasks)
                try realm.write {
                    realm.add(rootObject)
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func deleteSomeModelObjectFromRootModel(rootKeyId: String, someModelId: String) {
        do {
            let realm = try Realm() // Realm 객체 생성
            if let rootObject = getRootModelObject(forKey: rootKeyId) {
                if let index = rootObject.tasks.firstIndex(where: { $0.id == someModelId }) {
                    try realm.write {
                        rootObject.tasks.remove(at: index)
                    }
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
