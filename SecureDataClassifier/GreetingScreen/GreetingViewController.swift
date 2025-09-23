//
//  GreetingViewController.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 09.09.2025.
//

import UIKit

class GreetingViewController: UIViewController {
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Заголовок"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Полет начался с высоты 2300 метров. Он увидел небольшие просветы в небе и решил рискнуть. Сергей признался, что во время полета были проблемы с двигателем. Однако все прошло хорошо.Горизонт полностью просматривается, горы видны были, но, конечно, внимание чем-то притягивал Эльбрус. Он манит своей красотой и величием. Когда подлетел, то увидел людей, которые поднимаются на гору, кто-то уже находился на одной из вершин», — поделился впечатлениями собеседник."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var goButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)

        setup()
    }
    
    @objc func tapAction() {
        print("Tap")
        let VC = MainViewController()
        
        navigationController?.pushViewController(VC, animated: true)
    }
}

private extension GreetingViewController {
    
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(greetingLabel)
        view.addSubview(mainTitle)
        view.addSubview(descriptionLabel)
        view.addSubview(goButton)
    }
}

private extension GreetingViewController {

    func setupConstraints() {
        setupCpnstraintsForGreetingTitle()
        setupConstraintsForMainTitle()
        setupConstraintsForDesriptionlabel()
        setupConstraintsForButton()
    }
    
    func setupCpnstraintsForGreetingTitle() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 70),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupConstraintsForMainTitle() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor,constant: 62),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupConstraintsForDesriptionlabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: goButton.topAnchor, constant: -150),
        ])
    }
    
    func setupConstraintsForButton() {
        NSLayoutConstraint.activate([
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.heightAnchor.constraint(equalToConstant: 50),
            goButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
}
