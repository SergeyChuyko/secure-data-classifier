//
//  GreetingViewController.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 09.09.2025.
//

import UIKit

/// Greeting screen for the app, introduces the purpose and navigates to the main screen.
public final class GreetingViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let backgroundColor: UIColor = Colors.paleBlue
        static let buttonBackgroundColor: UIColor = Colors.primaryBlue
        static let labelColor: UIColor = Colors.textBlack
        static let descriptionColor: UIColor = Colors.grayDark
        static let buttonTintColor: UIColor = Colors.textWhite
        
        static let greetingTopInset: CGFloat = 45
        static let descriptionTopInset: CGFloat = 55
        static let horizontalInset: CGFloat = 16
        static let buttonHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 250
        
        static let spacing: CGFloat = 16
    }
    
    // MARK: - Views
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Классификация информационных систем"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.labelColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var backgroundForMainTitle: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryBlue
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Инструмент классификации и защиты информационных систем"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = Colors.textWhite
        label.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var backgroundForDescriptionLabel: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightBlue
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
                .font: UIFont.systemFont(ofSize: 18, weight: .regular),
                .foregroundColor: Colors.textBlack
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
        label.backgroundColor = Colors.lightBlue
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var goButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать", for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.tintColor = Constants.buttonTintColor
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        setup()
    }
    
    // MARK: - Actions
    
    @objc private func tapAction() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Setup

private extension GreetingViewController {
    
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(greetingLabel)
        view.addSubview(backgroundForDescriptionLabel)
        view.addSubview(goButton)
        
        backgroundForDescriptionLabel.addSubview(mainStack)
        
        mainStack.addArrangedSubview(backgroundForMainTitle)
        backgroundForMainTitle.addSubview(mainTitle)
        
        mainStack.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        setupConstraintsForGreetingLabel()
        setupConstraintsForBackgroundDescriptionLabel()
        setupConstraintsForMainStack()
        setupConstraintsForMainTitle()
        setupConstraintsForGoButton()
    }
    
    func setupConstraintsForGreetingLabel() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.greetingTopInset),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalInset),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalInset)
        ])
    }
    
    func setupConstraintsForBackgroundDescriptionLabel() {
        NSLayoutConstraint.activate([
            backgroundForDescriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: Constants.descriptionTopInset),
            backgroundForDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalInset),
            backgroundForDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalInset)
        ])
    }
    
    func setupConstraintsForMainStack() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: backgroundForDescriptionLabel.topAnchor, constant: Constants.spacing),
            mainStack.leadingAnchor.constraint(equalTo: backgroundForDescriptionLabel.leadingAnchor, constant: Constants.spacing),
            mainStack.trailingAnchor.constraint(equalTo: backgroundForDescriptionLabel.trailingAnchor, constant: -Constants.spacing),
            mainStack.bottomAnchor.constraint(equalTo: backgroundForDescriptionLabel.bottomAnchor, constant: -Constants.spacing)
        ])
    }
    
    func setupConstraintsForMainTitle() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: backgroundForMainTitle.topAnchor, constant: 8),
            mainTitle.leadingAnchor.constraint(equalTo: backgroundForMainTitle.leadingAnchor, constant: 8),
            mainTitle.trailingAnchor.constraint(equalTo: backgroundForMainTitle.trailingAnchor, constant: -8),
            mainTitle.bottomAnchor.constraint(equalTo: backgroundForMainTitle.bottomAnchor, constant: -8)
        ])
    }
    
    func setupConstraintsForGoButton() {
        NSLayoutConstraint.activate([
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            goButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            goButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
