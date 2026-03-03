//
//  PDFHistoryObject.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 22.11.2025.
//

import Foundation
import RealmSwift

final class PDFHistoryObject: Object {

    @Persisted(primaryKey: true) var id: String = UUID().uuidString

    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var filePath: String
}
