//
//  CitySelectorViewController.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class CitySelectorViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Public properties

    var presenter: CitySelectorPresenterProtocol?

    // MARK: - Private properties

    private let cityList = Dynamic<[Settlement]>([])

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    // MARK: - UI initial functions

    override final func performViews() {
        super.performViews()

        title = "scene.city_selector.title".localized
        performTableView()
    }

    override final func performStyles() {
        super.performStyles()

        view.backgroundColor = AppStyle.Color.sceneBackground
        tableView.separatorColor = AppStyle.Color.cellSeparator
    }

    override final func subscribeToObservers() {
        super.subscribeToObservers()

        cityList.bindAndFire { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - UI's protocol functions

extension CitySelectorViewController: CitySelectorViewProtocol {

    var presentable: UIViewController {
        return self
    }

    final func onShowSceneViewModel(with viewModel: CitySelectorViewModel) {
        self.cityList.value = viewModel.cityList
    }

    final func onShowFailureAlert(with message: String) {
        simpleAlert(message: message)
    }

}

// MARK: - UITableViewDelegate

extension CitySelectorViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.navigateToDetails(on: cityList.value[indexPath.row])
    }

}

// MARK: - UITableViewDataSource

extension CitySelectorViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListItemTableViewCell.reuseIdentifier, for: indexPath) as? CityListItemTableViewCell else {
            return UITableViewCell()
        }

        cell.perform(with: cityList.value[indexPath.row])

        return cell
    }

}

// MARK: - Private functions

private extension CitySelectorViewController {

    final func performTableView() {
        tableView.register(UINib(nibName: CityListItemTableViewCell.reuseIdentifier, bundle: .main),
                           forCellReuseIdentifier: CityListItemTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }

}
