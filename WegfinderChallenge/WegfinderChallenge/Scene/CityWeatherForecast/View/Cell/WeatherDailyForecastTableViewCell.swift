//
//  WeatherDailyForecastTableViewCell.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/9/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class WeatherDailyForecastTableViewCell: BaseTableViewCell {

    enum PublicConstants {
        static let cellHeight: CGFloat = 119
    }

    private enum PrivateConstants {
        static let cellItemWidth: CGFloat = 75
    }

    // MARK: - Outlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Private properties

    private let forecasts = Dynamic<[Forecast]>([])

    // MARK: - Lifecycle functions

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(UINib(nibName: WeatherForecastCollectionViewCell.reuseIdentifier, bundle: .main),
                                forCellWithReuseIdentifier: WeatherForecastCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        forecasts.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }

    override func clearContent() {
        super.clearContent()

        collectionView.scrollRectToVisible(.zero, animated: false)
        forecasts.value = []
    }

    final func performContent(with forecasts: [Forecast]?) {
        self.forecasts.value = forecasts?.sorted(by: { $0.date < $1.date }) ?? []
    }

}

// MARK: - UICollectionViewDataSource

extension WeatherDailyForecastTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastCollectionViewCell.reuseIdentifier, for: indexPath) as? WeatherForecastCollectionViewCell else { return UICollectionViewCell() }

        cell.performContent(with: forecasts.value[indexPath.item])

        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension WeatherDailyForecastTableViewCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherDailyForecastTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PrivateConstants.cellItemWidth, height: PublicConstants.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

}
