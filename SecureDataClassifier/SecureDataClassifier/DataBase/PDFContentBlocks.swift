//
//  PDFContentBlocks.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 27.10.2025.
//

import Foundation

// MARK: - Enum definitions

enum PDNCategory: String {
    case common = "Общие"
    case special = "Специальные"
    case biometric = "Биометрические"
    case mixed = "Смешанные"
}

enum DamageLevel: String {
    case high, medium, low, undefined
}

enum ScaleLevel: String {
    case object, regional, federal
}

enum AccessSubject: String {
    case administrator, management, accountant, contractor
}

enum AccessWay: String {
    case local, remote, mixed
}

// MARK: - PDF Block Texts

struct PDNCategoryText {
    static func text(for category: PDNCategory) -> String {
        switch category {
        case .common:
            return "Персональные данные относятся к категории общих. В их состав входят фамилия, имя, отчество, контактные данные и т.д."
        case .special:
            return "Персональные данные относятся к категории специальных, в том числе сведения о состоянии здоровья, национальной принадлежности и т.п."
        case .biometric:
            return "Персональные данные относятся к категории биометрических, включающих фотографии, отпечатки пальцев и иные биометрические сведения."
        case .mixed:
            return "Обработка включает сразу несколько категорий персональных данных: общие, специальные, биометрические."
        }
    }
}

struct SubjectCountText {
    static func text(for count: Int) -> String {
        switch count {
        case 0..<100:
            return "Обрабатывается менее 100 субъектов персональных данных."
        case 100..<1000:
            return "Обрабатывается от 100 до 1000 субъектов персональных данных."
        case 1000..<10000:
            return "Обрабатывается от 1000 до 10000 субъектов персональных данных."
        default:
            return "Обрабатывается более 10000 субъектов персональных данных."
        }
    }
}

struct PurposeText {
    static func text(from purpose: String) -> String {
        return "Цель обработки персональных данных: \(purpose)."
    }
}

struct AccessText {
    static func text(for subject: AccessSubject) -> String {
        switch subject {
        case .administrator:
            return "Доступ к информации имеют системные администраторы."
        case .management:
            return "Доступ к информации имеет руководство организации."
        case .accountant:
            return "Доступ к информации имеют сотрудники бухгалтерии."
        case .contractor:
            return "Доступ к информации имеют сторонние подрядчики."
        }
    }
}

struct AccessWayText {
    static func text(for way: AccessWay) -> String {
        switch way {
        case .local:
            return "Доступ к информации осуществляется исключительно с локальных устройств."
        case .remote:
            return "Доступ к информации возможен удалённо."
        case .mixed:
            return "Доступ к информации осуществляется как локально, так и удалённо."
        }
    }
}

