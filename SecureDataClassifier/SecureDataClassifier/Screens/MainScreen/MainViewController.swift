//
//  MainViewController.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 15.09.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        
        static let backgroundColor: UIColor = Colors.paleBlue
        static let labelColor: UIColor = Colors.textBlack
        static let placeholderColor: UIColor = Colors.grayLight
        
        static let textFieldBackground: UIColor = Colors.lightBlue
        static let textFieldCornerRadius: CGFloat = 12
        
        static let buttonBackgroundColor: UIColor = Colors.primaryBlue
        static let buttonDisabledBackground: UIColor = Colors.grayDark
        static let buttonTintColor: UIColor = Colors.textWhite
        
        static let buttonHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 200
        static let horizontalInset: CGFloat = 16
        static let verticalSpacing: CGFloat = 32
        static let fieldHeight: CGFloat = 44
        
        static let cornerForTextField: CGFloat = 8
        static let cornerForBackgroundView: CGFloat = 12
    }
    
    // MARK: - State
    
    private var systemName: String?              // Название ИС
    private var category: String?                // Категория персональных данных
    private var subjectsCount: String?              // Количество субъектов
    private var purpose: String?                 // Цель обработки
    private var access: String?                  // Кто имеет доступ
    private var accessWay: String?               // Способы доступа
    
    
    // MARK: - Properties
    
    private lazy var allTextFields: [UITextField] = [
        nameField,
        categoryField,
        countField,
        accessField,
        accessWayField
    ]
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        
        return scroll
    }()
    private lazy var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Colors.paleBlue
        
        return v
    }()
    
    private lazy var backgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = Constants.cornerForBackgroundView
        v.backgroundColor = Colors.lightBlue
        
        return v
    }()
    
    // MARK: Заголовок
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Данные информационной системы"
        label.numberOfLines = 2
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
        let tf = makeTextField(placeholder: "Введите число...")
        tf.keyboardType = .numberPad
        
        return tf
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
    
    private lazy var purposeTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Опишите цель..."
        textView.textColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        textView.backgroundColor = Colors.paleBlue
        textView.textColor = Colors.textBlack
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Colors.primaryBlue.cgColor
        
        return textView
        
    }()
    
    // MARK: - Loader Overlay

    private lazy var loaderOverlay: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        v.isHidden = true

        let loader = SDCLoader()
        loader.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(loader)

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: v.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 80),
            loader.heightAnchor.constraint(equalToConstant: 80)
        ])
        return v
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
        button.backgroundColor = Colors.richGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = Colors.grayDark.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(calculateAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Colors.candyRed
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.layer.shadowColor = Colors.grayDark.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.layer.masksToBounds = false
        
        let trashImage = UIImage(systemName: "trash.fill")
        button.setImage(trashImage, for: .normal)
        
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        navigationItem.hidesBackButton = true
        setup()
        styleTextFields()
        hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.backgroundColor = Colors.paleBlue
        setupKeyboardObservers()
        
        
        [nameField, categoryField, countField, accessField, accessWayField]
            .forEach { $0.delegate = self }
        purposeTextView.delegate = self
        
        scheduleInstructionAlert()
        setupNavigationBar()
        calculateButton.isEnabled = false
        calculateButton.backgroundColor = Colors.grayLight
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        deleteButton.isHidden = true
        hideKeyboardWhenTappedAround(action: #selector(dismissKeyboardCustom))
    }
    
    
    func setupNavigationBar() {
        let questionIcon = UIImage(systemName: "questionmark")
        let questionButton = UIBarButtonItem(
            image: questionIcon,
            style: .plain,
            target: self,
            action: #selector(questionTapped)
        )
        questionButton.tintColor = Colors.primaryBlue
        navigationItem.rightBarButtonItem = questionButton
    }
    
    
    public func updateCalculateButtonState() {
        let allFilled = systemName?.isEmpty == false &&
        category?.isEmpty == false &&
        subjectsCount?.isEmpty == false &&
        purpose?.isEmpty == false &&
        access?.isEmpty == false &&
        accessWay?.isEmpty == false
        
        if allFilled {
            calculateButton.isEnabled = true
            calculateButton.tintColor = Colors.textWhite
            
            calculateButton.backgroundColor = Colors.richGreen
        } else {
            calculateButton.isEnabled = false
            calculateButton.tintColor = Colors.textBlack
            calculateButton.backgroundColor = Colors.grayLight
        }
    }
    
    /// Обновляет видимость кнопки удаления
    public func updateDeleteButtonState() {
        let hasAnyValue = systemName?.isEmpty == false ||
        category?.isEmpty == false ||
        subjectsCount?.isEmpty == false ||
        purpose?.isEmpty == false ||
        access?.isEmpty == false ||
        accessWay?.isEmpty == false
        
        deleteButton.isHidden = !hasAnyValue
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
        view.addSubview(deleteButton)
        view.addSubview(loaderOverlay)

        
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundView)
        
        backgroundView.addSubview(mainTitle)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(nameField)
        backgroundView.addSubview(categoryLabel)
        backgroundView.addSubview(categoryField)
        backgroundView.addSubview(countLabel)
        backgroundView.addSubview(countField)
        backgroundView.addSubview(purposeLabel)
        backgroundView.addSubview(purposeTextView)
        backgroundView.addSubview(accessLabel)
        backgroundView.addSubview(accessField)
        backgroundView.addSubview(accessWayLabel)
        backgroundView.addSubview(accessWayField)
        backgroundView.addSubview(emptyView)
    }
    
    
    
}

// MARK: - Setup Constraints

private extension MainViewController {
    
    func setupConstraints() {
        setupConstraintsForScrollView()
        setupConstraintsForContentView()
        setupConstraintsForBackgroundView()
        setupConstraintsForMainTitle()
        setupConstraintsForName()
        setupConstraintsForCategory()
        setupConstraintsForCount()
        setupConstraintsForPurpose()
        setupConstraintsForAccess()
        setupConstraintsForAccessWay()
        setupConstraintsForCalculateButton()
        setupConstraintsForDeleteButton()
        setupConstraintsForEmptyView()
        setupConstraintsForLoader()
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
    
    func setupConstraintsForBackgroundView() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -8),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: accessWayField.bottomAnchor, constant: 16)
        ])
    }
    
    func setupConstraintsForMainTitle() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            mainTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupConstraintsForName() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 52),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            nameField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForCategory() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 32),
            categoryLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            
            categoryField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            categoryField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            categoryField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForCount() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: categoryField.bottomAnchor, constant: 32),
            countLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            
            countField.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 8),
            countField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            countField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            countField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForPurpose() {
        NSLayoutConstraint.activate([
            purposeLabel.topAnchor.constraint(equalTo: countField.bottomAnchor, constant: 32),
            purposeLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            
            purposeTextView.topAnchor.constraint(equalTo: purposeLabel.bottomAnchor, constant: 8),
            purposeTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            purposeTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            purposeTextView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func setupConstraintsForAccess() {
        NSLayoutConstraint.activate([
            accessLabel.topAnchor.constraint(equalTo: purposeTextView.bottomAnchor, constant: 32),
            accessLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            
            accessField.topAnchor.constraint(equalTo: accessLabel.bottomAnchor, constant: 8),
            accessField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            accessField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            accessField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupConstraintsForAccessWay() {
        NSLayoutConstraint.activate([
            accessWayLabel.topAnchor.constraint(equalTo: accessField.bottomAnchor, constant: 32),
            accessWayLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            
            accessWayField.topAnchor.constraint(equalTo: accessWayLabel.bottomAnchor, constant: 8),
            accessWayField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 16),
            accessWayField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            accessWayField.heightAnchor.constraint(equalToConstant: 44),
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
    
    func setupConstraintsForDeleteButton() {
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: calculateButton.trailingAnchor, constant: 16),
            deleteButton.topAnchor.constraint(equalTo: calculateButton.topAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupConstraintsForLoader() {
        NSLayoutConstraint.activate([
            loaderOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            loaderOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loaderOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Actions
extension MainViewController {
    
    /// MARK: Selection
    @objc private func cancelSelection() {
        view.endEditing(true)
    }
    
    @objc private func applySelection() {
        if categoryField.isFirstResponder {
            let value = categories[selectedCategoryIndex]
            categoryField.text = value
            category = value
            categoryField.resignFirstResponder()
            countField.becomeFirstResponder()
        } else if accessField.isFirstResponder {
            let value = accessOptions[selectedAccessIndex]
            accessField.text = value
            access = value
            accessField.resignFirstResponder()
            accessWayField.becomeFirstResponder()
        } else if accessWayField.isFirstResponder {
            let value = accessWays[selectedAccessWayIndex]
            accessWayField.text = value
            accessWay = value
            accessWayField.resignFirstResponder()
        } else {
            view.endEditing(true)
        }
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
    
    /// MARK: TextField Changes
    @objc private func nameChanged() {
        systemName = nameField.text
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
    
    @objc private func countChanged() {
        subjectsCount = countField.text
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
    
    @objc private func purposeChanged() {
        purpose = purposeTextView.text
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
    
    
    /// MARK: Keyboard
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
    
    
    /// MARK: Navigation
    @objc func questionTapped() {
        showCustomInstructionAlert()
    }
    
    /// MARK: Calculate
    @objc private func calculateAction() {
        logInputData()
        dismissKeyboardCustom()
        showLoaderOverlay()
        simulateProcessing()
    }
    
    /// MARK: All delete
    @objc func deleteAction() {
        // Очистка state
        systemName = nil
        category = nil
        subjectsCount = nil
        purpose = nil
        access = nil
        accessWay = nil
        
        // Очистка UI
        allTextFields.forEach { $0.text = nil }
        purposeTextView.text = nil
        
        // Обновление кнопок
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
}

// MARK: - TextField Helpers

private extension MainViewController {
    
    func styleTextFields() {
        allTextFields.forEach { tf in
            tf.backgroundColor = Colors.paleBlue
            tf.textColor = Colors.textBlack
            tf.layer.cornerRadius = 8
            tf.layer.masksToBounds = true
            tf.setLeftPaddingPoints(8)
            tf.layer.borderWidth = 1
            tf.layer.borderColor = Colors.primaryBlue.cgColor
        }
    }
    
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
        picker.backgroundColor = Colors.lightBlue
        tf.inputView = picker
        
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // 🔹 кастомный фон
        toolbar.isTranslucent = false
        toolbar.barTintColor = Colors.paleBlue
        
        let cancelButton = UIBarButtonItem(
            title: "Отмена",
            style: .plain,
            target: self,
            action: #selector(cancelSelection)
        )
        cancelButton.tintColor = Colors.candyRed
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let selectButton = UIBarButtonItem(
            title: "Выбрать",
            style: .done,
            target: self,
            action: #selector(applySelection)
        )
        selectButton.tintColor = Colors.richGreen
        
        toolbar.setItems([cancelButton, flexSpace, selectButton], animated: false)
        tf.inputAccessoryView = toolbar
        
        return tf
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Опишите цель..."
            textView.textColor = .lightGray
        }
        purpose = textView.text // сохраняем в state
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
    
}

// MARK: - UITextFieldDelegate and UITextViewDelegate
extension MainViewController: UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            categoryField.becomeFirstResponder()
        case categoryField:
            countField.becomeFirstResponder()
        case countField:
            purposeTextView.becomeFirstResponder()
        case purposeTextView:
            accessField.becomeFirstResponder()
        case accessField:
            accessWayField.becomeFirstResponder()
        case accessWayField:
            accessWayField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameField:
            systemName = textField.text
        case countField:
            subjectsCount = textField.text
        case purposeTextView:
            purpose = textField.text
        default:
            break
        }
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
}

extension MainViewController {
    @objc func dismissKeyboardCustom() {
        view.endEditing(true)
        updateCalculateButtonState()
        updateDeleteButtonState()
    }
}

// MARK: - Loader Helpers

private extension MainViewController {

    func showLoaderOverlay() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        loaderOverlay.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(loaderOverlay)

        NSLayoutConstraint.activate([
            loaderOverlay.topAnchor.constraint(equalTo: window.topAnchor),
            loaderOverlay.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            loaderOverlay.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            loaderOverlay.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])

        loaderOverlay.layoutIfNeeded()
        loaderOverlay.alpha = 0
        loaderOverlay.isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            self.loaderOverlay.alpha = 1
        }
    }

    func hideLoaderOverlay() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loaderOverlay.alpha = 0
        }, completion: { _ in
            self.loaderOverlay.removeFromSuperview()
        })
    }
}

// MARK: - Private helpers

private extension MainViewController {
    
    func logInputData() {
        print("→ Нажата кнопка Рассчитать")
        print("Название ИС: \(systemName ?? "—")")
        print("Категория ПДн: \(category ?? "—")")
        print("Количество субъектов: \(subjectsCount ?? "—")")
        print("Цель обработки: \(purpose ?? "—")")
        print("Кто имеет доступ: \(access ?? "—")")
        print("Способы доступа: \(accessWay ?? "—")")
    }
    
    func simulateProcessing() {
        let delay = Double.random(in: 2...6)
        print("⏳ Задержка \(String(format: "%.1f", delay)) сек.")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.hideLoaderOverlay()
            self?.proceedToResult()
        }
    }
    
    func proceedToResult() {
        guard self != nil else { return }
        
        let dataModel = SystemDataModel(
            systemName: systemName!,
            category: category!,
            subjectsCount: subjectsCount!,
            purpose: purpose!,
            access: access!,
            accessWay: accessWay!
        )
        
        AppData.shared.systemData = dataModel
        
        let pdfModel = PDFDocumentModel(systemData: dataModel)
        let pdfData = PDFGenerator.generate(from: pdfModel)
        let resultVC = ResultViewController(pdfData: pdfData)
        navigationController?.pushViewController(resultVC, animated: true)
    }
}
