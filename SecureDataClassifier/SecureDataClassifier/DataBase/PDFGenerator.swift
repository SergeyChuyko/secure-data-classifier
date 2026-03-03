//
//  PDFGenerator.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 02.10.2025.
//

import UIKit

struct PDFGenerator {
    static func generate(from model: PDFDocumentModel) -> Data {
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842) // A4
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)

        let data = renderer.pdfData { context in
            
            // ---------------------------------------------------------
            //               ТИТУЛЬНЫЙ ЛИСТ (ОТДЕЛЬНАЯ СТРАНИЦА)
            // ---------------------------------------------------------
              drawTitlePage(context: context, pageRect: pageRect, model: model)
            // !!! НИКАКОГО restore здесь НЕ нужно !!!
            // ---------------------------------------------------------

            // ---------------------------------------------------------
            //               ОСНОВНОЙ ТЕКСТ
            // ---------------------------------------------------------

            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16)
            ]

            let textRect = CGRect(
                x: 40,
                y: 120,
                width: pageRect.width - 80,
                height: pageRect.height - 160
            )

            let attributedText = NSAttributedString(string: model.introText, attributes: textAttributes)

            let framesetter = CTFramesetterCreateWithAttributedString(attributedText)
            var currentRange = CFRangeMake(0, 0)
            let fullLength = attributedText.length

            var pageIndex = 1

            while currentRange.location < fullLength {

                context.beginPage()
                context.cgContext.saveGState()

                // Инверсия координат ТОЛЬКО для CoreText
                let flipY = textRect.origin.y * 2 + textRect.height
                
                
                
                
                context.cgContext.translateBy(x: 0, y: flipY)
                context.cgContext.scaleBy(x: 1, y: -1)

                let path = CGMutablePath()
                path.addRect(textRect)

                let frame = CTFramesetterCreateFrame(framesetter, currentRange, path, nil)
                let frameRange = CTFrameGetVisibleStringRange(frame)

                CTFrameDraw(frame, context.cgContext)
                context.cgContext.restoreGState()

                currentRange.location += frameRange.length

                // Нумерация (по желанию)
                // drawPageNumber(context: context, pageRect: pageRect, pageIndex: pageIndex)

                let isLastPage = currentRange.location >= fullLength

                if isLastPage {
                    let footerAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 16, weight: .medium)
                    ]

                    model.footer.draw(
                        in: CGRect(x: 40, y: pageRect.height - 60, width: pageRect.width - 80, height: 40),
                        withAttributes: footerAttributes
                    )
                }

                pageIndex += 1
            }
        }

        return data
    }
}

//
// MARK: - Титульный лист
//
private extension PDFGenerator {
    static func drawTitlePage(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        model: PDFDocumentModel
    ) {
        context.beginPage()

        context.cgContext.saveGState()   // ← ДВА ВАШИХ СПАСАТЕЛЯ

        // ⬇️ Титульник без единого переворота
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .paragraphStyle: centered()
        ]

        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: centered()
        ]

        let leftAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .paragraphStyle: leftAligned()
        ]

        let rightAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .paragraphStyle: rightAligned()
        ]

        let currentYear = Calendar.current.component(.year, from: Date())

        "ПАСПОРТ ИНФОРМАЦИОННОЙ СИСТЕМЫ".draw(
            in: CGRect(x: 40, y: 220, width: pageRect.width - 80, height: 40),
            withAttributes: titleAttributes
        )

        model.systemData.systemName.draw(
            in: CGRect(x: 40, y: 280, width: pageRect.width - 80, height: 30),
            withAttributes: subtitleAttributes
        )

        let signatureY = pageRect.height - 160

        "Ответственный: ___________________".draw(
            in: CGRect(x: 40, y: signatureY, width: pageRect.width / 2 - 50, height: 20),
            withAttributes: leftAttributes
        )

        "Дата: ___/___/_______".draw(
            in: CGRect(x: pageRect.width / 2 + 10, y: signatureY,
                       width: pageRect.width / 2 - 50, height: 20),
            withAttributes: rightAttributes
        )

        "Новосибирск \(currentYear)".draw(
            in: CGRect(x: 40, y: pageRect.height - 60, width: pageRect.width - 80, height: 20),
            withAttributes: subtitleAttributes
        )

        context.cgContext.restoreGState()  // ← ВОТ ЭТО СПАСАЕТ ТЕКСТ
    }
}

//
// MARK: - Нумерация
//
private extension PDFGenerator {
    static func drawPageNumber(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        pageIndex: Int
    ) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.gray
        ]

        let text = "\(pageIndex)"

        text.draw(
            in: CGRect(x: pageRect.width - 50, y: pageRect.height - 40, width: 40, height: 20),
            withAttributes: attributes
        )
    }
}

//
// MARK: - Paragraph Styles
//
private extension PDFGenerator {
    static func centered() -> NSMutableParagraphStyle {
        let s = NSMutableParagraphStyle()
        s.alignment = .center
        return s
    }

    static func leftAligned() -> NSMutableParagraphStyle {
        let s = NSMutableParagraphStyle()
        s.alignment = .left
        return s
    }

    static func rightAligned() -> NSMutableParagraphStyle {
        let s = NSMutableParagraphStyle()
        s.alignment = .right
        return s
    }
}
