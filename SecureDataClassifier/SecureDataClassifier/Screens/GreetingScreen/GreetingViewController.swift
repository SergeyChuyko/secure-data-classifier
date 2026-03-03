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
    
    private lazy var infoView: SDCInfoAboutApplication = {
        let view = SDCInfoAboutApplication()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
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
        // 🔹 Тень
        button.layer.shadowColor = Colors.grayDark.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.layer.masksToBounds = false
        
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
        view.addSubview(infoView)
        view.addSubview(goButton)
    }
    
    func setupConstraints() {
        setupConstraintsForGreetingLabel()
        setupConstraintsForInfoView()
        setupConstraintsForGoButton()
    }
    
    func setupConstraintsForGreetingLabel() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.greetingTopInset),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalInset),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalInset)
        ])
    }
    
    func setupConstraintsForInfoView() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 55),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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
