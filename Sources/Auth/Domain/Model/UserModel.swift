//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 04/01/23.
//

import Foundation

public struct UserModel: Equatable {
    public let user_id: String?
    public let user_code: String?
    public let role: String?
    public let type: String?
    public let no_type: String?
    public let doctor_id: String?
    public let speciality_id: Int?
    public let speciality_slug: String?
    public let hospital: [HospitalModel]?
    public let hospital_active: HospitalModel?
    public let name: String?
    public let username: String?
    public let gender: String?
    public let place_of_birth: String?
    public let date_of_birth: String?
    public let is_actived: Bool
    public let email: String?
    public let phone_number: String?
    public let country_id: String?
    public let country_name: String?
    public let provinces_id: String?
    public let provinces_name: String?
    public let regencies_cities_id: String?
    public let regencies_cities_name: String?
    public let villages_id: String?
    public let villages_name: String?
    public let districts_id: String?
    public let districts_name: String?
    public let postal_code: String?
    public let rt: String?
    public let rw: String?
    public let home_address: String?
    public let current_address: String?
    public let current_country_name: String?
    public let current_country_id: String?
    public let current_provinces_id: String?
    public let current_provinces_name: String?
    public let current_regencies_cities_id: String?
    public let current_regencies_cities_name: String?
    public let current_villages_id: String?
    public let current_villages_name: String?
    public let current_districts_id: String?
    public let current_districts_name: String?
    public let current_postal_code: String?
    public let current_rt: String?
    public let current_rw: String?
    public let obgyn: String?
    public let current_disease_name: String?
    public let updated_at_current_disease: String?
    public let current_ews: String?
    public let updated_at_current_ews: String?
    public let created_at: String?
    public let thumb: String?
}

public struct HospitalModel: Equatable {
    public let name: String?
    public let doctor_hospital_id: Int?
}
