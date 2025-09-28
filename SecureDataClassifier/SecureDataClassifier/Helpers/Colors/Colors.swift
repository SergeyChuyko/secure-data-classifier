//
//  Colors.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 23.09.2025.
//

import UIKit


public enum Colors {
    // Основные
    static let primaryBlue = UIColor(red: 0.0, green: 0.47, blue: 1.0, alpha: 1.0)   // 🔵 синий для кнопок
    static let lightBlue   = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)    // голубой для текстфилдов
    static let paleBlue    = UIColor(red: 0.93, green: 0.96, blue: 1.0, alpha: 1.0)  // бледно-голубой для фона

    // Текстовые
    static let textWhite   = UIColor.white
    static let textBlack   = UIColor.black
    
    // Серые оттенки
    static let grayLight   = UIColor(white: 0.85, alpha: 1.0)   // очень бледный серый (для плейсхолдеров)
    static let gray        = UIColor(white: 0.6, alpha: 1.0)    // стандартный серый (для описаний)
    static let grayDark    = UIColor(white: 0.3, alpha: 1.0)    // тёмно-серый (для менее акцентных заголовков)
    
    // Новые
    static let candyRed    = UIColor(red: 0.85, green: 0.0, blue: 0.25, alpha: 1.0) // 🍒 вишнёвый красный
    static let richGreen   = UIColor(red: 0.0, green: 0.6, blue: 0.2, alpha: 1.0)   // 🌱 насыщенный зелёный
    static let inactiveGreen = UIColor(red: 0.6, green: 0.8, blue: 0.6, alpha: 1.0)

}

