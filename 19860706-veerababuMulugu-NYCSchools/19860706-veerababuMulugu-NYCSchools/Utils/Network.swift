//
//  Network.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import Foundation

private let schoolListUrl = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
private let schoolDetailsUrl = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class Network {
    static let shared = Network()
    private init() {}
    
    func fetchSchools(searchText: String, offset: Int, limit: Int) async throws -> [School] {
        
        let filterFields = URLQueryItem(name: "$select", value: "dbn,school_name,phone_number,school_email,website,latitude,longitude,primary_address_line_1,city,zip,state_code".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed))
        let offset = URLQueryItem(name: "$offset", value: String(offset))
        let limit = URLQueryItem(name: "$limit", value: String(limit))
        let q = URLQueryItem(name: "$q", value: searchText)
        
        var components = URLComponents(string: schoolListUrl)
        components?.queryItems = [filterFields, offset, limit, q]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        let response = try await URLSession.shared.data(from: url)
        do {
            let results = try JSONDecoder().decode([School].self, from: response.0)
            return results
        } catch {
            throw NetworkError.noData
        }
    }
    
    func fetchSchoolsDetails(id: String) async throws -> SATScore {
        
        let dbn = URLQueryItem(name: "dbn", value: id)
        
        var components = URLComponents(string: schoolDetailsUrl)
        components?.queryItems = [dbn]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        let response = try await URLSession.shared.data(from: url)
        
        do {
            if let satScore = try JSONDecoder().decode([SATScore].self, from: response.0).first {
                return satScore
            } else {
                throw NetworkError.noData
            }
        } catch {
            throw NetworkError.noData
        }
    }
    
}
