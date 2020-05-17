//
//  LocalizedString.swift
//  Assignment
//
//  Created by Vandana Kanwar on 17/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import Foundation

enum LocalizedString: CustomStringConvertible {
    case errorAlertTitle
    case alertOkButtonTitle
    var description: String {
        switch self {
        case .errorAlertTitle:
            return localizeString("errorAlertTitle",
                                  comment: "errorAlertTitle")
        case .alertOkButtonTitle:
            return localizeString("alertOkButtonTitle",
                                             comment: "alertOkButtonTitle")
        }
    }
}

extension LocalizedString {
    private func localizeString(_ key: String, comment: String, _ arguments: CVarArg...) -> String {
        let format = NSLocalizedString(key,
                                       tableName: nil,
                                       bundle: Bundle(for: BundleIdentifierClass.self),
                                       comment: comment)
        return String(format: format, locale: Locale.current, arguments: arguments)
    }
}

private final class BundleIdentifierClass {}
