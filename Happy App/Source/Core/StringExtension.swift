//
//  StringExtension.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

extension String {
    enum Translation: String {
        case titleBefore = "title_before"
        case resultsHint = "results_hint"
        case titleWaiting = "title_waiting"
        case titleAfter = "title_after"
        case titleErrorSubmitting = "error_submitting"
        case titleErrorUnknown = "error_unknown"
    }

    static func forTranslation(_ translation: String.Translation) -> String {
        let text = NSLocalizedString(translation.rawValue, comment: "")
        return text.count > 0 ? text : "-- Error: \(translation.rawValue) --"
    }
}
