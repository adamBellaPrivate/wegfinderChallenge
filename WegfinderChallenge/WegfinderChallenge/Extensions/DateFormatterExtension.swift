//
//  DateFormatterExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/9/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var normalDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter
    }

    static var timeDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

}
