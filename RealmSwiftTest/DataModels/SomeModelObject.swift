//
//  SomeModelObject.swift
//  RealmSwiftTest
//
//  Created by Jiny on 2023/11/02.
//

import Foundation
import RealmSwift

class SomeModelObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var desc: String
    @Persisted var isDone: Bool
    @Persisted var date: Date
    @Persisted var optionType: List<Int>
    @Persisted var rootId: String
    @Persisted var createdBy: Date

    convenience init(title: String) {
        self.init()
        self.id = UUID().uuidString
        self.title = title
        self.desc = ""
        self.isDone = false
        self.date = Date()
        self.optionType = List<Int>()
        self.rootId = ""
        self.createdBy = Date()
    }
}
