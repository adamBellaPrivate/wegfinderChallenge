//
//  FileWorker.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

struct FileWorker {

    private enum PrivateConstants {
        static let extensionJSON = "json"
        static let filenameCityList = "CityList"
    }

    private let fileWorkerQueue = DispatchQueue(label: "thread_file_worker")

}

// MARK: - Public class's functions

extension FileWorker: FileWorkerProtocol {

    func fetchCityList(_ handler: @escaping (Result<[Settlement], Error>) -> Void) {
        Thread.executeOnBackground(queue: fileWorkerQueue) {
            guard let data = self.loadFileContent(fileName: PrivateConstants.filenameCityList) else {
                Thread.executeOnMain {
                    handler(.failure(AppError.fileReadingError))
                }
                return
            }

            do {
                let cityList = try JSONDecoder().decode([Settlement].self, from: data)
                Thread.executeOnMain {
                    handler(.success(cityList))
                }
            } catch let error {
                Thread.executeOnMain {
                    handler(.failure(error))
                }
            }
        }
    }

}

// MARK: - Private class's functions

private extension FileWorker {

    /*
       This function can read file from a bundle.
    */

    func loadFileContent(fileName: String,
                         withExtension ext: String = PrivateConstants.extensionJSON,
                         bundle: Bundle = .main) -> Data? {
        do {
            guard let filePathURL = bundle.url(forResource: fileName, withExtension: ext) else {
                return .none
            }
            return try Data(contentsOf: filePathURL)
        } catch {
            return .none
        }
    }

}
