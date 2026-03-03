//
//  PDFStorageManager.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 22.11.2025.
//

import UIKit
import RealmSwift

struct PDFStorageManager {

    static func savePDF(_ data: Data, title: String) {
        do {
            // 1. Сохраняем PDF в Documents
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let filename = UUID().uuidString + ".pdf"
            let fileURL = documents.appendingPathComponent(filename)

            try data.write(to: fileURL)

            // 2. Создаём Realm-объект
            let obj = PDFHistoryObject()
            obj.title = title
            obj.date = Date()
            obj.filePath = fileURL.path

            // 3. Пишем в Realm
            let realm = try Realm()
            try realm.write {
                realm.add(obj)
            }

            print("📄 PDF сохранён в Realm: \(fileURL.path)")

        } catch {
            print("❌ Ошибка сохранения PDF: \(error)")
        }
    }
}
