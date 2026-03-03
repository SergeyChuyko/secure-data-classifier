//
//  PDFReportBuilder.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 27.10.2025.
//

import Foundation

enum PDFReportBuilder {
    static func build(for data: SystemDataModel) -> String {
        var result = ""

        // Название системы
        result += "Информационная система:\n"
        result += "\(data.systemName)\n\n"

        // Категория ПДн
        if let category = PDNCategory(rawValue: data.category) {
            result += "Категория ПДн:\n"
            result += PDNCategoryText.text(for: category) + "\n\n"
        }

        // Количество субъектов
        if let count = Int(data.subjectsCount) {
            result += "Количество субъектов:\n"
            result += SubjectCountText.text(for: count) + "\n\n"
        }

        // Цель обработки
        result += "Цель обработки:\n"
        result += PurposeText.text(from: data.purpose) + "\n\n"

        // Кто имеет доступ
        if let subject = AccessSubject(rawValue: data.access) {
            result += "Кто имеет доступ:\n"
            result += AccessText.text(for: subject) + "\n\n"
        }

        // Способы доступа
        if let way = AccessWay(rawValue: data.accessWay) {
            result += "Способы доступа:\n"
            result += AccessWayText.text(for: way) + "\n\n"
        }

        // Требования к защите — зависит от категории
        if let category = PDNCategory(rawValue: data.category) {
            result += "Требования к защите:\n"
            result += determineSecurityLevel(for: category) + "\n\n"
        }

        // Базовые и компенсирующие меры
        result += "Базовые меры:\n"
        result += BaseMeasures.defaultBlock + "\n\n"

        result += "Компенсирующие меры:\n"
        result += CompensatoryMeasures.defaultBlock

        return result
    }

    private static func determineSecurityLevel(for category: PDNCategory) -> String {
        switch category {
        case .common:
            return SecurityRequirements.level1
        case .special:
            return SecurityRequirements.level2
        case .biometric, .mixed:
            return SecurityRequirements.level3
        }
    }
}
