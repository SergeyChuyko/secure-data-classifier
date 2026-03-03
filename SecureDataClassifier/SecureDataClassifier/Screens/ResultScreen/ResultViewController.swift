//
//  ResultViewController.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 02.10.2025.
//

import UIKit
import PDFKit
import RealmSwift

// MARK: - ResultViewController

/// Screen that displays the generated PDF and allows the user to save it.
final class ResultViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {

        static let containerCornerRadius: CGFloat = 12
        static let containerHorizontalInset: CGFloat = 30
        static let containerVerticalInset: CGFloat = 16
        static let pdfInset: CGFloat = 0
        
        static let saveButtonBottomInset: CGFloat = -16
        static let saveButtonSize = CGSize(width: 200, height: 50)
        static let saveButtonCornerRadius: CGFloat = 10
        
        static let backgroundColor: UIColor = Colors.paleBlue
        static let saveButtonColor: UIColor = .systemBlue
        static let saveButtonShadowOpacity: Float = 0.7
        static let saveButtonShadowOffset = CGSize(width: 0, height: 4)
        static let saveButtonShadowRadius: CGFloat = 6
    }
    
    // MARK: - Private properties
    
    private let pdfData: Data
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical

        return pdfView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить PDF", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = Constants.saveButtonColor
        button.tintColor = .white
        button.layer.cornerRadius = Constants.saveButtonCornerRadius
        button.layer.shadowColor = Colors.grayDark.cgColor
        button.layer.shadowOpacity = Constants.saveButtonShadowOpacity
        button.layer.shadowOffset = Constants.saveButtonShadowOffset
        button.layer.shadowRadius = Constants.saveButtonShadowRadius
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(savePDF), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Init
    
    init(pdfData: Data) {
        self.pdfData = pdfData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

private extension ResultViewController {
    
    func setup() {
        view.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.backgroundColor = Colors.paleBlue

        addSubviews()
        setupConstraints()
        configurePDF()
        setupNavigationBar()
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        view.addSubview(saveButton)
        containerView.addSubview(pdfView)
    }
    
    func setupConstraints() {
        setupConstraintsForContainer()
        setupConstraintsForPDFView()
        setupConstraintsForSaveButton()
    }
    
    func setupConstraintsForContainer() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupConstraintsForPDFView() {
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Constants.pdfInset
            ),
            pdfView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Constants.pdfInset
            ),
            pdfView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -Constants.pdfInset
            ),
            pdfView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -Constants.pdfInset
            )
        ])
    }
    
    func setupConstraintsForSaveButton() {
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: Constants.saveButtonSize.width),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.saveButtonSize.height),
            saveButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: Constants.saveButtonBottomInset
            ),
        ])
    }
}

// MARK: - Configuration

private extension ResultViewController {
    
    func configurePDF() {
        if let document = PDFDocument(data: pdfData) {
            pdfView.document = document
        }
    }
    
    func updatePDF(with data: Data) {
        if let document = PDFDocument(data: data) {
            pdfView.document = document
        }
    }
}

// MARK: - Actions

private extension ResultViewController {

    func saveToHistory(pdfData: Data) {
        let fileName = UUID().uuidString + ".pdf"
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent(fileName)

        do {
            try pdfData.write(to: url)

            let realm = try Realm()
            try realm.write {
                let obj = PDFHistoryObject()
                obj.title = AppData.shared.systemData?.systemName ?? "Без названия"
                obj.date = Date()
                obj.filePath = url.path
                realm.add(obj)
            }

            print("📄 PDF сохранён в Realm: \(url.path)")

        } catch {
            print("❌ Ошибка сохранения PDF: \(error)")
        }
    }

    @objc func savePDF() {
        saveToHistory(pdfData: pdfData)

        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Result.pdf")
        try? pdfData.write(to: tempURL)

        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    @objc func historyTapped() {
        let historyVC = PDFHistoryViewController()
        historyVC.delegate = self
        if let sheet = historyVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(historyVC, animated: true)
    }
}

//MARK: - Nav Bar Setup

private extension ResultViewController {
    
    func setupNavigationBar() {
        let questionIcon = UIImage(systemName: "book.fill")
        let questionButton = UIBarButtonItem(
            image: questionIcon,
            style: .plain,
            target: self,
            action: #selector(historyTapped)
        )
        questionButton.tintColor = Colors.primaryBlue
        navigationItem.rightBarButtonItem = questionButton
    }
}

extension ResultViewController: PDFHistorySelectionDelegate {
    func didSelectPDF(data: Data) {
        print("🔥 Получили PDF из истории!")
        
        if let document = PDFDocument(data: data) {
            pdfView.document = document
        } else {
            print("❌ Не удалось создать документ из Data")
        }
    }
}
