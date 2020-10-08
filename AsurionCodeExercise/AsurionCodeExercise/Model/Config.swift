//
//  Config.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

enum DaysofaWeek: Int {
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

struct Config: Decodable {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
    
    // Return (start day, end day, start time hour, start time minute, end time hour, end time minute)
    func getDecodedWorkHours() -> (DaysofaWeek, DaysofaWeek, Int, Int, Int, Int)? {
        
        var decodedString: (DaysofaWeek, DaysofaWeek, Int, Int, Int, Int)?
        
        var output_startDay: DaysofaWeek!
        var output_endDay: DaysofaWeek!
        
        var output_startTimeHour: Int!
        var output_startTimeMinute: Int!
        
        var output_endTimeHour: Int!
        var output_endTimeMinute: Int!
        
        let daysTimeArray = workHours.split(separator: " ", maxSplits: 1)
        
        if daysTimeArray.count == 2 {
            let daysArray = daysTimeArray[0].split(separator: "-")
            let timeArray =  daysTimeArray[1].split(separator: "-")
            if daysArray.count == 2  && timeArray.count == 2 {
                
                guard let startWeekDay = getDayOfaWeek(day: String(daysArray[0])), let endWeekDay = getDayOfaWeek(day: String(daysArray[1])) else {
                    return nil
                }
                output_startDay = startWeekDay
                output_endDay = endWeekDay
                
                guard let startTime = getHoursMinutes(time: String(timeArray[0])), let endTime = getHoursMinutes(time: String(timeArray[1])) else {
                    return nil
                }
                output_startTimeHour = startTime.0
                output_startTimeMinute = startTime.1
                output_endTimeHour = endTime.0
                output_endTimeMinute = endTime.1
                
                decodedString = (output_startDay, output_endDay, output_startTimeHour, output_startTimeMinute, output_endTimeHour, output_endTimeMinute)
            }
        }
        
        return decodedString
    }
    
    private func getHoursMinutes(time: String) -> (Int, Int)? {
        let trimmedTimeString = time.trimmingCharacters(in: .whitespaces)
        let hourMinuteArray = trimmedTimeString.split(separator: ":")
        if hourMinuteArray.count == 2 {
            let hour = hourMinuteArray[0]
            let minute = hourMinuteArray[1]
            guard let h = Int(hour), let m = Int(minute) else {
                return nil
            }
            return (h, m)
        }
        return nil
    }
    
    private func getDayOfaWeek(day: String) -> DaysofaWeek? {
        let dayOfWeek: DaysofaWeek?
        switch day {
        case "Sun":
            dayOfWeek = .Sunday
        case "M":
            dayOfWeek = .Monday
        case "Tues":
            dayOfWeek = .Tuesday
        case "W":
            dayOfWeek = .Wednesday
        case "Thurs":
            dayOfWeek = .Thursday
        case "F":
            dayOfWeek = .Friday
        case "Sat":
            dayOfWeek = .Saturday
        default:
            dayOfWeek = nil
        }
        return dayOfWeek
    }
}

struct Settings: Decodable {
    let config: Config
    
    enum CodingKeys: String, CodingKey {
        case config = "settings"
    }
}
