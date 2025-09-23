//
//  MainViewController.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 15.09.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private lazy var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    // MARK: Заголовок
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Заголовок"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Название ИС
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название ИС"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameField: UITextField = {
        return makeTextField(placeholder: "Введите название...")
    }()
    
    // MARK: - Категория перс данных

    private let categories = [
        "Общие",
        "Специальные",
        "Биометрические",
        "Обезличенные"
    ]

    private var selectedCategoryIndex: Int = 0

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория перс данных"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var categoryField: UITextField = {
        return makePickerTextField(tag: 1, placeholder: "Выберите...")
    }()

    
    // MARK: Кол-во субъектов ПДн
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "Кол-во субъектов ПДн"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countField: UITextField = {
        return makeTextField(placeholder: "Введите число...")
    }()
    
    // MARK: Цель обработки
    private lazy var purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "Цель обработки данных"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var purposeField: UITextField = {
        return makeTextField(placeholder: "Опишите цель...")
    }()
    
    // MARK: Доступ

    private let accessOptions = [
        "Администраторы",
        "Сотрудники отдела кадров",
        "Бухгалтерия",
        "Руководство",
        "IT-поддержка",
        "Сторонние подрядчики"
    ]

    private var selectedAccessIndex: Int = 0

    private lazy var accessLabel: UILabel = {
        let label = UILabel()
        label.text = "Кто имеет доступ"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accessField: UITextField = {
        return makePickerTextField(tag: 2, placeholder: "Выберите...")
    }()

    
    // MARK: Способы доступа
    private let accessWays = [
        "Чтение",
        "Запись",
        "Изменение",
        "Удаление",
        "Администрирование"
    ]

    private var selectedAccessWayIndex: Int = 0

    private lazy var accessWayLabel: UILabel = {
        let label = UILabel()
        label.text = "Способы доступа"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accessWayField: UITextField = {
        return makePickerTextField(tag: 3, placeholder: "Выберите...")
    }()

    
    //MARK: - Пустая вью
    
    private lazy var emptyView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    // MARK: Кнопка рассчета
    private lazy var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Рассчитать", for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(calculateAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        title = "Penis Silo"
        navigationItem.hidesBackButton = true   
        setup()
        hideKeyboardWhenTappedAround()
        
        setupKeyboardObservers()
        
        // делегаты для всех текстфилдов
        [nameField, categoryField, countField, purposeField, accessField, accessWayField]
            .forEach { $0.delegate = self }
    }


    
    // MARK: - Actions
    @objc private func calculateAction() {
        print("→ Нажата кнопка Рассчитать")
    }
}

// MARK: - Setup
private extension MainViewController {
    func setup() {
        addSubviews()
        setupConstraints()
        setupKeyboardObservers()
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(calculateButton)

        scrollView.addSubview(contentView)   // <--- вот эта строка обязательна

        contentView.addSubview(mainTitle)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameField)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryField)
        contentView.addSubview(countLabel)
        contentView.addSubview(countField)
        contentView.addSubview(purposeLabel)
        contentView.addSubview(purposeField)
        contentView.addSubview(accessLabel)
        contentView.addSubview(accessField)
        contentView.addSubview(accessWayLabel)
        contentView.addSubview(accessWayField)
        contentView.addSubview(emptyView)
    }

    
    
}

// MARK: - Setup Constraints

private extension MainViewController {
    
    func setupConstraints() {
        setupConstraintsForScrollView()
        setupConstraintsForContentView()
        setupConstraintsForMainTitle()
        setupConstraintsForName()
        setupConstraintsForCategory()
        setupConstraintsForCount()
        setupConstraintsForPurpose()
        setupConstraintsForAccess()
        setupConstraintsForAccessWay()
        setupConstraintsForCalculateButton()
        setupConstraintsForEmptyView()
    }
    
    func setupConstraintsForScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupConstraintsForContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    
    
    
    func setupConstraintsForMainTitle() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            mainTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupConstraintsForName() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 52),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForCategory() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 32),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            categoryField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoryField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForCount() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: categoryField.bottomAnchor, constant: 32),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            countField.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 8),
            countField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            countField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForPurpose() {
        NSLayoutConstraint.activate([
            purposeLabel.topAnchor.constraint(equalTo: countField.bottomAnchor, constant: 32),
            purposeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            purposeField.topAnchor.constraint(equalTo: purposeLabel.bottomAnchor, constant: 8),
            purposeField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            purposeField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            purposeField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForAccess() {
        NSLayoutConstraint.activate([
            accessLabel.topAnchor.constraint(equalTo: purposeField.bottomAnchor, constant: 32),
            accessLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            accessField.topAnchor.constraint(equalTo: accessLabel.bottomAnchor, constant: 8),
            accessField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            accessField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            accessField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForAccessWay() {
        NSLayoutConstraint.activate([
            accessWayLabel.topAnchor.constraint(equalTo: accessField.bottomAnchor, constant: 32),
            accessWayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            accessWayField.topAnchor.constraint(equalTo: accessWayLabel.bottomAnchor, constant: 8),
            accessWayField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            accessWayField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            accessWayField.heightAnchor.constraint(equalToConstant: 44),
            //accessWayStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupConstraintsForEmptyView() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: accessWayField.bottomAnchor, constant: 0),
            emptyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            emptyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            emptyView.heightAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    func setupConstraintsForCalculateButton() {
        NSLayoutConstraint.activate([
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 200),
            calculateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func cancelSelection() {
        view.endEditing(true) // закрывает текущий активный inputView
    }

    @objc private func applySelection() {
        if categoryField.isFirstResponder {
            categoryField.text = categories[selectedCategoryIndex]
            categoryField.resignFirstResponder()
            countField.becomeFirstResponder()   // переход к следующему
        } else if accessField.isFirstResponder {
            accessField.text = accessOptions[selectedAccessIndex]
            accessField.resignFirstResponder()
            accessWayField.becomeFirstResponder() // переход к следующему
        } else if accessWayField.isFirstResponder {
            accessWayField.text = accessWays[selectedAccessWayIndex]
            accessWayField.resignFirstResponder()
            // последний — просто закрываем
        } else {
            view.endEditing(true)
        }
    }




}


// MARK: - Helpers
private extension MainViewController {
    func makeTextField() -> UITextField {
        let tf = UITextField()
        tf.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
        tf.layer.cornerRadius = 6
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setLeftPaddingPoints(8)
        return tf
    }
}

private extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return categories.count
        case 2: return accessOptions.count
        case 3: return accessWays.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return categories[row]
        case 2: return accessOptions[row]
        case 3: return accessWays[row]
        default: return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            selectedCategoryIndex = row
        case 2:
            selectedAccessIndex = row
        case 3:
            selectedAccessWayIndex = row
        default:
            break
        }
    }
}


extension UIViewController {
    /// Скрывает клавиатуру/пикеры при тапе вне UITextField
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false // чтобы другие нажатия (например, на кнопки) работали
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            categoryField.becomeFirstResponder()
        case categoryField:
            countField.becomeFirstResponder()
        case countField:
            purposeField.becomeFirstResponder()
        case purposeField:
            accessField.becomeFirstResponder()
        case accessField:
            accessWayField.becomeFirstResponder()
        case accessWayField:
            accessWayField.resignFirstResponder() // последний закрывает клавиатуру/пикер
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Keyboard Handling
private extension MainViewController {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
}


private extension MainViewController {
    /// Базовая визуальная настройка всех текстфилдов
    func styleTextField(_ tf: UITextField, placeholder: String? = nil) {
        tf.placeholder = placeholder
        tf.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
        tf.textColor = .red
        tf.layer.cornerRadius = 12
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setLeftPaddingPoints(8)
    }

    func makeTextField(placeholder: String? = nil) -> UITextField {
        let tf = UITextField()
        styleTextField(tf, placeholder: placeholder)
        return tf
    }

    func makePickerTextField(tag: Int, placeholder: String) -> UITextField {
        let tf = UITextField()
        styleTextField(tf, placeholder: placeholder)

        // Picker
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.tag = tag
        tf.inputView = picker

        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let cancelButton = UIBarButtonItem(
            title: "Отмена",
            style: .plain,
            target: self,
            action: #selector(cancelSelection)
        )
        cancelButton.tintColor = .systemRed

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let selectButton = UIBarButtonItem(
            title: "Выбрать",
            style: .done,
            target: self,
            action: #selector(applySelection)
        )
        selectButton.tintColor = .systemGreen

        toolbar.setItems([cancelButton, flexSpace, selectButton], animated: false)
        tf.inputAccessoryView = toolbar

        return tf
    }
}
