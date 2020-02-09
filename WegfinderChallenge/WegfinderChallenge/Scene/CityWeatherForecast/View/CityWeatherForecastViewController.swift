//
//  CityWeatherForecastViewController.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class CityWeatherForecastViewController: BaseViewController {

    private enum PrivateConstants {

        static let emptyHolder = "--"

    }

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var lblCurrentMinTemperature: UILabel!
    @IBOutlet private weak var lblCurrentMaxTemperature: UILabel!
    @IBOutlet private weak var lblCurrentTemperature: UILabel!
    @IBOutlet private weak var lblNowPlaceholder: UILabel!
    @IBOutlet private weak var lblCurrentWeather: UILabel!
    @IBOutlet private weak var lblCityName: UILabel!

    // MARK: - Public properties

    var presenter: CityWeatherForecastPresenterProtocol?

    // MARK: - Private properties

    private let selectedCity = Dynamic<City?>(.none)
    private let currentWeather = Dynamic<Forecast?>(.none)
    private let forecasts = Dynamic<OrderedContent>(([], [:]))
    private lazy var btnSearch = UIBarButtonItem(barButtonSystemItem: .search,
                                                 target: self,
                                                 action: #selector(didTapOnSearchMenu))

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    // MARK: - UI initial functions

    override final func performViews() {
        super.performViews()

        title = "scene.city_weather_forecast.title".localized
        setupTableView()
    }

    override final func performStyles() {
        super.performStyles()

        lblCityName.font = AppStyle.Font.medium(of: 30)
        lblCurrentMinTemperature.font = AppStyle.Font.regular(of: 20)
        lblCurrentMaxTemperature.font = AppStyle.Font.regular(of: 20)
        lblCurrentTemperature.font = AppStyle.Font.regular(of: 70)
        lblNowPlaceholder.font = AppStyle.Font.regular(of: 20)
        lblCurrentWeather.font = AppStyle.Font.regular(of: 18)

        lblCurrentMinTemperature.textColor = AppStyle.Color.textPrimary?.withAlphaComponent(0.7)
        lblCurrentMaxTemperature.textColor = AppStyle.Color.textPrimary
        lblCurrentTemperature.textColor = AppStyle.Color.textPrimary
        lblNowPlaceholder.textColor = AppStyle.Color.textPrimary
        lblCurrentWeather.textColor = AppStyle.Color.textPrimary
        lblCityName.textColor = AppStyle.Color.textPrimary

        view.backgroundColor = AppStyle.Color.sceneBackground
    }

    override final func subscribeToObservers() {
        super.subscribeToObservers()

        selectedCity.bindAndFire { [weak self] _ in
            self?.performCity()
        }

        currentWeather.bindAndFire { [weak self] _ in
            self?.performCurrentWeather()
        }

        forecasts.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - UI's protocol functions

extension CityWeatherForecastViewController: CityWeatherForecastViewProtocol {

    var presentable: UIViewController {
        return self
    }

    final func onShowSceneViewModel(with viewModel: CityWeatherForecastViewModel) {
        selectedCity.value = viewModel.city
        forecasts.value = viewModel.orderedForecasts
        if let nowKey = viewModel.orderedForecasts.orderedKeys.first(where: { Calendar.current.isDateInToday($0) }) {
            currentWeather.value = viewModel.orderedForecasts.forecasts[nowKey]?.first
        } else {
            currentWeather.value = .none
        }
    }

    final func onShowFailureAlert(with message: String) {
        simpleAlert(message: message)
    }

}

// MARK: - UITableViewDataSource

extension CityWeatherForecastViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return forecasts.value.orderedKeys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDailyForecastTableViewCell.reuseIdentifier, for: indexPath) as? WeatherDailyForecastTableViewCell else { return UITableViewCell() }

        let key = forecasts.value.orderedKeys[indexPath.section]
        cell.performContent(with: forecasts.value.forecasts[key])

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = forecasts.value.orderedKeys[section]

        if Calendar.current.isDateInToday(date) {
            return "scene.city_weather_forecast.today".localized
        } else if Calendar.current.isDateInTomorrow(date) {
            return "scene.city_weather_forecast.tomorrow".localized
        }

        return DateFormatter.normalDateFormat.string(from: date)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}

// MARK: - UITableViewDelegate

extension CityWeatherForecastViewController: UITableViewDelegate {}

// MARK: - Private functions

private extension CityWeatherForecastViewController {

    // MARK: - Setup table view

    final func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: WeatherDailyForecastTableViewCell.reuseIdentifier, bundle: .main),
                           forCellReuseIdentifier: WeatherDailyForecastTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = WeatherDailyForecastTableViewCell.PublicConstants.cellHeight
        tableView.rowHeight = WeatherDailyForecastTableViewCell.PublicConstants.cellHeight
    }

    // MARK: - Perform header

    final func performCity() {
        lblCityName.text = selectedCity.value?.name ?? PrivateConstants.emptyHolder
        navigationItem.rightBarButtonItem = selectedCity.value != nil ? btnSearch : .none
    }

    final func performCurrentWeather() {
        lblCurrentMinTemperature.text = currentWeather.value?.main.tempMin?.toTemperature() ?? PrivateConstants.emptyHolder
        lblCurrentMaxTemperature.text = currentWeather.value?.main.tempMax?.toTemperature() ?? PrivateConstants.emptyHolder
        lblCurrentTemperature.text = currentWeather.value?.main.temp?.toTemperature() ?? PrivateConstants.emptyHolder
        lblCurrentWeather.text = currentWeather.value?.weather.first?.main ?? PrivateConstants.emptyHolder
    }

    // MARK: - Actions

    @objc final func didTapOnSearchMenu() {
        selectedCity.value?.coordinate?.openMaps(with: selectedCity.value?.name)
    }

}
