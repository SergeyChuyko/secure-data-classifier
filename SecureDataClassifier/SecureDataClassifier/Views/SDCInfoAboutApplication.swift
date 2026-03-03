//
//  SDCInfoAboutApplication.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 10.10.2025.
//

import UIKit

/// Информационный блок, описывающий возможности приложения.
/// Используется на приветственном экране и может быть переиспользован в других местах.
public final class SDCInfoAboutApplication: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let backgroundColor: UIColor = Colors.lightBlue
        static let titleBackgroundColor: UIColor = Colors.primaryBlue
        static let titleTextColor: UIColor = Colors.textWhite
        static let descriptionTextColor: UIColor = Colors.textBlack
        
        static let cornerRadius: CGFloat = 12
        static let titleCornerRadius: CGFloat = 8
        
        static let stackSpacing: CGFloat = 16
        static let contentInset: CGFloat = 16
        
        static let titleFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
        static let descriptionFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
    }
    
    // MARK: - Private views
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var backgroundForMainTitle: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.titleBackgroundColor
        view.layer.cornerRadius = Constants.titleCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Инструмент классификации и защиты информационных систем"
        label.textAlignment = .left
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        
        let fullText = """
        В нём вы можете:
        
        • Определять категорию персональных данных (общие, специальные, биометрические)
        • Указывать количество субъектов персональных данных
        • Задавать цели обработки информации
        • Настраивать доступ и способы взаимодействия пользователей с данными
        • Формировать отчёты для дальнейшей работы и документирования
        • Автоматически подбирать меры защиты в соответствии с требованиями
        """
        
        let attributed = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: Constants.descriptionFont,
                .foregroundColor: Constants.descriptionTextColor
            ]
        )
        
        if let range = fullText.range(of: "В нём вы можете:") {
            let nsRange = NSRange(range, in: fullText)
            attributed.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: 18, weight: .bold),
                range: nsRange
            )
        }
        
        label.attributedText = attributed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(mainStack)
        
        mainStack.addArrangedSubview(backgroundForMainTitle)
        backgroundForMainTitle.addSubview(mainTitle)
        
        mainStack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: Constants.contentInset),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.contentInset),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.contentInset),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.contentInset),
            
            mainTitle.topAnchor.constraint(equalTo: backgroundForMainTitle.topAnchor, constant: 8),
            mainTitle.leadingAnchor.constraint(equalTo: backgroundForMainTitle.leadingAnchor, constant: 8),
            mainTitle.trailingAnchor.constraint(equalTo: backgroundForMainTitle.trailingAnchor, constant: -8),
            mainTitle.bottomAnchor.constraint(equalTo: backgroundForMainTitle.bottomAnchor, constant: -8)
        ])
    }
}
