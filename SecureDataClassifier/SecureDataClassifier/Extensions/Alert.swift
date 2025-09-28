//
//  Alert.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 28.09.2025.
//

import UIKit

extension MainViewController {
    
    func showCustomInstructionAlert() {
        guard let containerView = navigationController?.view ?? view else { return }
        
        // Фон-затемнение
        let dimView = UIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        dimView.alpha = 0
        containerView.addSubview(dimView)
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Сам alert
        let alertView = UIView()
        alertView.backgroundColor = Colors.paleBlue
        alertView.layer.cornerRadius = 8
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.alpha = 0
        
        alertView.layer.shadowColor = Colors.grayDark.cgColor
        alertView.layer.shadowOpacity = 0.7
        alertView.layer.shadowOffset = CGSize(width: 0, height: 4)
        alertView.layer.shadowRadius = 6
        alertView.layer.masksToBounds = false
        
        // Текст
        let label = UILabel()
        label.text = "Заполните поля ниже для расчёта класса ИС и подбора мер защиты"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Colors.textBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Линия-разделитель
        let separator = UIView()
        separator.backgroundColor = Colors.gray
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        // Кнопка
        let button = UIButton(type: .system)
        button.setTitle("Понятно", for: .normal)
        button.setTitleColor(Colors.primaryBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissCustomAlert(_:)), for: .touchUpInside)
        
        alertView.addSubview(label)
        alertView.addSubview(separator)
        alertView.addSubview(button)
        dimView.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            alertView.centerYAnchor.constraint(equalTo: dimView.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: dimView.centerXAnchor),
            alertView.leadingAnchor.constraint(equalTo: dimView.leadingAnchor, constant: 55),
            alertView.trailingAnchor.constraint(equalTo: dimView.trailingAnchor, constant: -55),
            
            label.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            
            separator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            button.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 4),
            button.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -4),
            button.centerXAnchor.constraint(equalTo: alertView.centerXAnchor)
        ])
        
        // Плавное появление
        UIView.animate(withDuration: 0.5) {
            dimView.alpha = 1
            alertView.alpha = 1
        }
    }
    
    @objc func dismissCustomAlert(_ sender: UIButton) {
        guard let alertView = sender.superview,
              let dimView = alertView.superview else { return }
        
        UIView.animate(withDuration: 0.5, animations: {
            alertView.alpha = 0
            dimView.alpha = 0
        }, completion: { _ in
            dimView.removeFromSuperview()
        })
    }
    
    func scheduleInstructionAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showCustomInstructionAlert()
        }
    }
}
