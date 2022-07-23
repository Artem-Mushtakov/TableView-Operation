//
//  CocktailsViewController.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit
import SnapKit

protocol CocktailsViewOutputProtocol: AnyObject {
    func succes()
}

class CocktailsViewController: UIViewController {

    var presenter: CocktailsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoctailsTableViewCell.self, forCellReuseIdentifier: "CoctailsTableViewCell")
        return tableView
    } ()

    private func setupLayout() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension CocktailsViewController: CocktailsViewOutputProtocol {

    func succes() {
        tableView.reloadData()
    }
}

extension CocktailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model?.drinks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoctailsTableViewCell", for: indexPath) as? CoctailsTableViewCell

        if let model = presenter?.model?.drinks?[indexPath.row], let cell = cell {
            cell.imageUrlIdentifier = model.strDrinkThumb
            cell.loadDataCell(text: model.strDrink)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.addLoadImage(willDisplay: cell, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.removeProviderOperation(didEndDisplaying: cell, indexPath: indexPath)
    }
}

extension CocktailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
