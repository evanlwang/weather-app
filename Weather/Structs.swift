//
//  Structs.swift
//  Weather
//
//  Created by Evan Wang on 5/29/20.
//  Copyright © 2020 Evan Wang. All rights reserved.
//

import SwiftUI

struct Request: Decodable {
    let type: String?
    let query: String?
    let language: String?
    let unit: String?
}

struct Location: Decodable {
    let name: String?
    let country: String?
    let region: String?
    let lat: String?
    let lon: String?
    let timezone_id: String?
    let localtime:String?
    let localtime_epoch: Int?
    let utc_offset: String?
}

struct Current : Decodable {
    let observation_time : String?
    let temperature : Int?
    let weather_code : Int?
    let weather_icons : [String?]
    let weather_descriptions : [String?]
    let wind_speed : Int?
    let wind_degree : Int?
    let wind_dir : String?
    let pressure : Int?
    let precip : Double?
    let humidity : Int?
    let cloudcover : Int?
    let feelslike : Int?
    let uv_index : Int?
    let visibility : Int?
}

struct Weather: Decodable {
    let request: Request?
    let location: Location?
    let current: Current?
}
