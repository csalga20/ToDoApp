//
//  Task.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/19/22.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {//protocols come from realm
    
    //persisted comes from realm
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
