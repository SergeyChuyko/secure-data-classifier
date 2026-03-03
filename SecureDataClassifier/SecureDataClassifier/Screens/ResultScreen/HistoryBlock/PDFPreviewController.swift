import UIKit
import PDFKit

final class PDFPreviewController: UIViewController {

    private let document: PDFDocument

    init(document: PDFDocument?) {
        self.document = document ?? PDFDocument()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private lazy var pdfView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoScales = true
        view.displayMode = .singlePageContinuous
        view.displayDirection = .vertical
        view.document = document
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(pdfView)

        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
