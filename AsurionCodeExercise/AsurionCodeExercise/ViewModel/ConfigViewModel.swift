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
            return NSLocalizedString("withinWorkHoursMessage", comment: "")
        }
    }
    
    var outsideWorkHoursMessage: String {
        get {
            return NSLocalizedString("outsideWorkHoursMessage", comment: "")
        }
    }
    
    var isChatEnabled: Bool? {
        get {
            return config?.isChatEnabled
        }
    }
    
    var isCallEnabled: Bool? {
        get {
            return config?.isCallEnabled
        }
    }
    
    var workHours: String? {
        get {
            return config?.workHours
        }
    }
    
    func loadConfig(_ completion: @escaping () -> ()) {
        DataService.shared.loadConfig { (config, error) in
            guard let config = config, error == nil else {
                return
            }
            self.config = config
            completion()
        }
    }
    
    func callChatAlertMessage() -> String {
        var message = outsideWorkHoursMessage
        if let withInWorkHours = isNowTimeWithinWorkHours(), withInWorkHours == true {
            message = withinWorkHoursMessage
        }
        return message
    }
    
    private func isNowTimeWithinWorkHours() -> Bool? {
        
        var isYes = false
        
        let calendar = Calendar.current
        let now = Date()
        
        guard let decodedWorkHours = config?.getDecodedWorkHours() else {
            return nil
        }
        
        let startDay = decodedWorkHours.0.rawValue
        let endDay = decodedWorkHours.1.rawValue
        
        let start_time_today = calendar.date(
            bySettingHour: decodedWorkHours.2,
            minute: decodedWorkHours.3,
            second: 0,
            of: now)!
        
        let end_time_today = calendar.date(
            bySettingHour: decodedWorkHours.4,
            minute: decodedWorkHours.5,
            second: 0,
            of: now)!
        
        if now >= start_time_today &&
            now <= end_time_today &&
            startDay...endDay ~= calendar.component(.weekday, from: now)
        {
            isYes = true
        }
        
        return isYes
    }
}
