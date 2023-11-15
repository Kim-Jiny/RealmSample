//
//  RootModel.swift
//  RealmSwiftTest
//
//  Created by Jiny on 2023/11/02.
//

import Foundation
import RealmSwift

class RootModelObject: Object {
    @Persisted(primaryKey: true) var key: String
    @Persisted var tasks = List<SomeModelObject>()
  
  convenience init(key: String, tasks: [SomeModelObject]) {
        self.init()
        self.key = key
        self.tasks.append(objectsIn: tasks)
    }
}
