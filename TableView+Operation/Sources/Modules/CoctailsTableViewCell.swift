//
//  CoctailsTableViewCell.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

class CoctailsTableViewCell: UITableViewCell {

    // MARK: - Initial

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    } ()

    private lazy var imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage().defaultImage()
        return imageView
    } ()

    var imageUrlIdentifier: String? {
        didSet {
            if imageUrlIdentifier != nil {
                updateImageViewWithImage(nil)
            }
        }
    }

    // MARK:  - Settings

    private func setupHierarchy(){
        self.addSubview(titleLabel)
        self.addSubview(imageCell)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(imageCell.snp.leading).offset(-20)
            $0.height.equalTo(30)
        }

        imageCell.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(120)
            $0.width.equalTo(120)
        }
    }

    func loadDataCell(text: String?) {
        if let text = text {
            titleLabel.text = text
        }
    }

    func updateImageViewWithImage(_ image: UIImage?) {
        if let image = image {
            imageCell.image = image
        } else {
            imageCell.image = UIImage().defaultImage()
        }
    }
}
