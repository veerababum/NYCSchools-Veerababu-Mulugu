//
//  School.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import Foundation

struct School: Decodable {
    let id : String
    let name: String
    
    let phoneNumber: String
    let email: String?
    let website: String
    
    let addresLine: String
    let city: String
    let zip: String
    let state: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
        case phoneNumber = "phone_number"
        case email = "school_email"
        case website = "website"
        case latitude = "latitude"
        case longitude = "longitude"
        case addresLine = "primary_address_line_1"
        case city
        case zip
        case state = "state_code"
    }
}

extension School {
    static var fake: School {
        let school = School(id: "01M448", name: "University Neighborhood High School", phoneNumber: "212-962-4341", email: "KChu@schools.nyc.gov", website: "www.universityneighborhoodhs.org", addresLine: "West St", city: "Rochester", zip: "74657", state: "NY", latitude: "40.71227", longitude: "-73.9841")
        return school
    }
}
