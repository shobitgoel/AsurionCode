//
//  Config.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

enum DaysofaWeek: Int {
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Unknown = -1
}

struct Config: Decodable {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
    
    // Return (start day, end day, start time hour, start time minute, end time hour, end time minute)
    func getDecodedWorkHours() -> (DaysofaWeek?, DaysofaWeek?, Int, Int, Int, Int) {
        let daysTimeArray = workHours.split(separator: " ", maxSplits: 1)
        
        let daysArray = daysTimeArray[0].split(separator: "-")
        let startDay = daysArray[0]
        let endDay = daysArray[1]
        
        let timeArray =  daysTimeArray[1].split(separator: "-")
        let startTime = getHoursMinutes(time: String(timeArray[0]))
        let endTime = getHoursMinutes(time: String(timeArray[1]))
        
        return (getDayOfaWeek(day: String(startDay)), getDayOfaWeek(day: String(endDay)),
                startTime.0, startTime.1,
                endTime.0, endTime.1)
    }
    
    private func getHoursMinutes(time: String) -> (Int, Int) {
        let trimmedTimeString = time.trimmingCharacters(in: .whitespaces)
        let hourMinuteArray = trimmedTimeString.split(separator: ":")
        let hour = hourMinuteArray[0]
        let minute = hourMinuteArray[1]
        return (Int(hour)!, Int(minute)!)
    }
    
    private func getDayOfaWeek(day: String) -> DaysofaWeek {
        let dayOfWeek: DaysofaWeek
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
            dayOfWeek = .Unknown
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
