//
//  PDFGenerator.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 02.10.2025.
//

import UIKit

struct PDFGenerator {
    
    static func generate(from model: SystemDataModel) -> Data {
        let format = UIGraphicsPDFRendererFormat()
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842) // A4
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
            
            let text = """
            Название ИС: \(String(describing: model.systemName))
            Категория ПДн: \(String(describing: model.category))
            Количество субъектов: \(String(describing: model.subjectsCount))
            Цель обработки: \(String(describing: model.purpose))
            Кто имеет доступ: \(String(describing: model.access))
            Способы доступа: \(String(describing: model.accessWay))
            """
            
            text.draw(at: CGPoint(x: 40, y: 40), withAttributes: attributes)
        }
        
        return data
    }
}

