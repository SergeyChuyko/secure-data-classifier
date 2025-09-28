//
//  Singleton.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 28.09.2025.
//

import Foundation

final class AppData {
    static let shared = AppData()
    private init() {}

    var systemData: SystemDataModel?
}
