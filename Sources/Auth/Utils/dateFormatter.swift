//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 11/05/23.
//

import Foundation


func dateFormatterDateOfBirthFromDate(dateVal: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC+07")
    dateFormatter.dateFormat = "dd MMM yyyy"
    let resultString = dateFormatter.string(from: dateVal)
    return resultString
}



func dateFormatterDateOfBirthFromString(dateVal: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateVal)
    dateFormatter.dateFormat = "dd MMM yyyy"
    let resultString = dateFormatter.string(from: date ?? Date())
    return resultString
}

