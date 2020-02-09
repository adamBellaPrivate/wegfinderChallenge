//
//  NetworkWorker.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

class NetworkWorker {

    private enum PrivateConstants {

        static let successStatusCode = 200
        static let apiConfigFileName = "ApiConfig"

    }

    // MARK: - Private properties

    private let apiConfig: Config

    // MARK: - Public properties

    var iconResourcePath: String {
        return apiConfig.iconResourcePath
    }

    // MARK: - Lifecycle functions

    init() {
        apiConfig = NetworkWorker.loadApiConfig(by: .dev)
    }

}

// MARK: - Public API functions

extension NetworkWorker: NetworkWorkerProtocol {

    final func fetchWeatherForecast(by cityId: String,
                                    onComplition handler: @escaping NetworkAnswerCallback<CityWeatherForecastApiResponse>) {
        requestAPI(with: CityWeatherForecastApiRequest(cityId: cityId),
                   responseType: CityWeatherForecastApiResponse.self,
                   handler: handler)
    }

}

// MARK: - Private functions

private extension NetworkWorker {

    // MARK: - Load API config

    static func loadApiConfig(by environmentType: ApiEnvironmentType) -> Config {
        guard let configPath = Bundle.main.path(forResource: PrivateConstants.apiConfigFileName,
                                                                ofType: "plist"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: configPath)),
              let settings = try? PropertyListDecoder().decode(SerializableConfig.self, from: data),
              let config = settings[environmentType.rawValue.uppercased()] else {
                fatalError(AppError.missingConfig.localizedDescription)
        }

        return config
    }

    // MARK: - Base API request function
    // swiftlint:disable function_body_length
    final func requestAPI<U: ApiRequestProtocol, T: Decodable>(with request: U,
                                                               responseType: T.Type,
                                                               handler: @escaping NetworkAnswerCallback<T>) {
        guard let url = URL(string: apiConfig.baseUrl + request.urlPath) else {
            Thread.executeOnMain {
                handler(Result.failure(AppError.invalidApiURL))
            }
            return
        }

        var urlParams = [URLQueryItem]()

        if request.isAuthRequired {
            urlParams.append(URLQueryItem(name: "appid", value: apiConfig.weatherApiId))
        }

        if !request.urlParams.isEmpty {
            urlParams.append(contentsOf: request.urlParams)
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = urlParams

        let fixedUrl = urlComponents?.url ?? url

        var urlRequest = URLRequest(url: fixedUrl)
        urlRequest.httpMethod = request.method.rawValue.uppercased()

        logApiRequest(url: fixedUrl, method: request.method, params: urlParams)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error {
                self?.logApiErrorResponse(response: response, error: error)
                Thread.executeOnMain {
                    handler(Result.failure(error))
                }
            } else if let urlResponse = response as? HTTPURLResponse {
                self?.logApiResponse(response: urlResponse, data: data)
                switch urlResponse.statusCode {
                case PrivateConstants.successStatusCode where data != nil:
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let parsedObject = try decoder.decode(responseType, from: data!)
                        Thread.executeOnMain {
                            handler(Result.success(parsedObject))
                        }
                    } catch let error {
                        #if DEBUG
                            NSLog(error.localizedDescription)
                        #endif
                        DispatchQueue.main.async {
                            handler(Result.failure(AppError.invalidResponse))
                        }
                    }
                case PrivateConstants.successStatusCode where data == nil:
                    Thread.executeOnMain {
                            handler(Result.failure(AppError.invalidResponse))
                    }
                default:
                    Thread.executeOnMain {
                        handler(Result.failure(AppError.businessError(urlResponse.statusCode)))
                    }
                }
            } else {
                 Thread.executeOnMain {
                    handler(Result.failure(AppError.unknown))
                 }
            }
        }

        task.resume()
    }

    // MARK: - Debug log methods

    final func logApiRequest(url: URL,
                             method: HttpMethod,
                             params: [URLQueryItem]? = .none) {

        #if DEBUG
            var paramsString = ""
            if let params = params {
                paramsString = "\n\t\(params)"
            }

            NSLog("API request method: \(method.rawValue), url: \(url)\(paramsString)")
        #endif
    }

    final func logApiResponse(response: HTTPURLResponse, data: Data?) {
        #if DEBUG
            NSLog("API response url: \(String(describing: response.url)), status code: \(response.statusCode),\n\tcontent: \(String(describing: String(data: data ?? Data(), encoding: .utf8)))")
        #endif
    }

    final func logApiErrorResponse(response: URLResponse?, error: Error) {
        #if DEBUG
            NSLog("API error response url: \(response?.url?.absoluteString ?? ""),\n\tcontent: \(error.localizedDescription)")
        #endif
    }

}
