//
//  ErrorWorker.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

/*
    Available custom error types in the application.
 */

enum AppError: Error {

    case invalidApiURL
    case invalidResponse
    case fileReadingError
    case businessError(Int)
    case missingConfig
    case unknown

}

struct ErrorWorker: ErrorWorkerProtocol {

    /*
        This function will give you an user friendly message of error, if it possible.
    */

    func perform(error err: Error) -> String {
        guard let apiError = err as? AppError else { return err.localizedDescription }

        switch apiError {
        case .invalidResponse,
             .invalidApiURL,
             .missingConfig:
            return "general_error".localized
        case .fileReadingError:
            return "file_reading_error".localized
        case .businessError(let statusCode):
            return String(format: "business_error".localized, statusCode)
        case .unknown:
            return "unknown_error".localized
        }
    }

}
