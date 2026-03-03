import UIKit
import RealmSwift
import PDFKit


protocol PDFHistorySelectionDelegate: AnyObject {
    func didSelectPDF(data: Data)
}

final class PDFHistoryViewController: UIViewController {

    private var items: [PDFHistoryItem] = []
    
    weak var delegate: PDFHistorySelectionDelegate?
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PDFHistoryCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        loadHistory()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func loadHistory() {
        do {
            let realm = try Realm()
            let objects = realm.objects(PDFHistoryObject.self).sorted(byKeyPath: "date", ascending: false)

            self.items = objects.compactMap { obj in
                let url = URL(fileURLWithPath: obj.filePath)
                return PDFHistoryItem(
                    id: obj.id,
                    title: obj.title,
                    date: obj.date,
                    fileURL: url
                )
            }

        } catch {
            print("❌ Ошибка загрузки истории: \(error)")
        }
    }
}

extension PDFHistoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PDFHistoryCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]

        let url = item.fileURL

        guard let data = try? Data(contentsOf: url) else {
            print("❌ Не удалось прочитать PDF: \(url.path)")
            return
        }

        delegate?.didSelectPDF(data: data)   // 🔥 Передаём данные на старый экран
        print("🔥 didSelectRowAt")
        print("delegate = \(delegate)")
        dismiss(animated: true)              // 🔥 Закрываем историю
    }
}
