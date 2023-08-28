//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 04/01/23.
//

import Foundation

public struct AuthResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case code
        case success
        case message
        case data
    }
    
    let code: String
    let success: Bool
    let message: String
    let data: AuthDataResponse?
    
}

public struct AuthDataResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case user
        case access_token
    }
    
    let user: UserResponse?
    let access_token: String?
}

public struct HospitalResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case doctor_hospital_id
    }
    
    let name: String?
    let doctor_hospital_id: Int?
}

public struct UserResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case user_id
        case user_code
        case role
        case type
        case no_type
        case doctor_id
        case speciality_id
        case speciality_slug
        case hospital
        case hospital_active
        case name
        case username
        case gender
        case place_of_birth
        case date_of_birth
        case is_actived
        case email
        case phone_number
        case country_id
        case country_name
        case provinces_id
        case provinces_name
        case regencies_cities_id
        case regencies_cities_name
        case villages_id
        case villages_name
        case districts_id
        case districts_name
        case postal_code
        case rt
        case rw
        case home_address
        case current_address
        case current_country_name
        case current_country_id
        case current_provinces_id
        case current_provinces_name
        case current_regencies_cities_id
        case current_regencies_cities_name
        case current_villages_id
        case current_villages_name
        case current_districts_id
        case current_districts_name
        case current_postal_code
        case current_rt
        case current_rw
        case obgyn
        case current_disease_name
        case updated_at_current_disease
        case current_ews
        case updated_at_current_ews
        case created_at
        case thumb
    }
    
    let user_id: String?
    let user_code: String?
    let role: String?
    let type: String?
    let no_type: String?
    let doctor_id: String?
    let speciality_id: Int?
    let speciality_slug: String?
    let hospital: [HospitalResponse]
    let hospital_active: HospitalResponse?
    let name: String?
    let username: String?
    let gender: String?
    let place_of_birth: String?
    let date_of_birth: String?
    let is_actived: Bool
    let email: String?
    let phone_number: String?
    let country_id: String?
    let country_name: String?
    let provinces_id: String?
    let provinces_name: String?
    let regencies_cities_id: String?
    let regencies_cities_name: String?
    let villages_id: String?
    let villages_name: String?
    let districts_id: String?
    let districts_name: String?
    let postal_code: String?
    let rt: String?
    let rw: String?
    let home_address: String?
    let current_address: String?
    let current_country_name: String?
    let current_country_id: String?
    let current_provinces_id: String?
    let current_provinces_name: String?
    let current_regencies_cities_id: String?
    let current_regencies_cities_name: String?
    let current_villages_id: String?
    let current_villages_name: String?
    let current_districts_id: String?
    let current_districts_name: String?
    let current_postal_code: String?
    let current_rt: String?
    let current_rw: String?
    let obgyn: String?
    let current_disease_name: String?
    let updated_at_current_disease: String?
    let current_ews: String?
    let updated_at_current_ews: String?
    let created_at: String?
    let thumb: String?
}





