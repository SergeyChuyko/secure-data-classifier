//
//  PDFDocumentModel.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 02.10.2025.
//

import UIKit
import PDFKit

struct PDFDocumentModel {
    let systemData: SystemDataModel
    let introText: String
    let footer: String

    init(systemData: SystemDataModel) {
        self.systemData = systemData
        self.introText = PDFReportBuilder.build(for: systemData)


        self.footer = "Новосибирск 2025"
    }
}
