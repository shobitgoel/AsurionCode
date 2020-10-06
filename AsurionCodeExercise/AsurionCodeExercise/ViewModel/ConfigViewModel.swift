//
//  ConfigViewModel.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 05/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

class ConfigViewModel {
    
    var config: Config?
        
    var withinWorkHoursMessage: String {
        get {
            return "Thank you for getting in touch with us. We'll get back to you as soon as possible"
        }
    }
    
    var outsideWorkHoursMessage: String {
        get {
            return "Work hours has ended. Please contact us again on the next work day"
        }
    }
    
    var isChatEnabled: Bool {
        get {
            return config?.isChatEnabled ?? false
        }
    }
    
    var isCallEnabled: Bool {
        get {
            return config?.isCallEnabled ?? false
        }
    }
    
    var workHours: String? {
        get {
            return config?.workHours
        }
    }
    
    func loadConfig(_ completion: @escaping () -> ()) {
        DataService.shared.loadConfig{ (config, error) in
            guard let config = config, error == nil else {
                return
            }
            self.config = config
            completion()
        }
    }
    
    // Assumption: Office hours is 9 - 18 Monday to Friday
    // Should actually come from service in ios convertable date format
    func isNowTimeWithinWorkHours() -> Bool {
        
        var isYes = false
        
        let calendar = Calendar.current
        let now = Date()
        
        let nine_am_today = calendar.date(
            bySettingHour: 9,
            minute: 0,
            second: 0,
            of: now)!
        
        let six_pm_today = calendar.date(
            bySettingHour: 18,
            minute: 0,
            second: 0,
            of: now)!
        
        if now >= nine_am_today &&
            now <= six_pm_today &&
            2...6 ~= calendar.component(.weekday, from: now)
        {
            isYes = true
        }
        
        return isYes
    }
    
    func alertMessage() -> String {
        var message = outsideWorkHoursMessage
        if (isNowTimeWithinWorkHours()) {
            message = withinWorkHoursMessage
        }
        return message
    }
}
