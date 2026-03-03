//
//  PDFHistoryCell.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 22.11.2025.
//

import UIKit

final class PDFHistoryCell: UITableViewCell {

    // MARK: - Views

    private let iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "doc.richtext"))
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let hStack = UIStackView(arrangedSubviews: [iconView, textStack])
        hStack.axis = .horizontal
        hStack.spacing = 12
        hStack.alignment = .center

        hStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hStack)

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Configure

    func configure(with item: PDFHistoryItem) {
        titleLabel.text = item.title

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd.MM.yy"
        subtitleLabel.text = formatter.string(from: item.date)
    }
}

