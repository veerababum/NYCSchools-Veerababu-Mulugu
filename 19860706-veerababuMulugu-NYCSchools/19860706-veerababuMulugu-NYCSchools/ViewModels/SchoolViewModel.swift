//
//  SchoolViewModel.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import Combine
import CoreLocation
import Foundation

///SchoolViewModel
final class SchoolViewModel: Identifiable, ObservableObject {
    
    var id = UUID() //For Identifiable
    
    private let school: School
    @Published private(set) var isFavourite: Bool = false
    
    @Published
    var satScore: SATScore?
    
    init(school: School) {
        self.school = school
        isFavourite = NYCDefaults.shared.isFavorite(id: school.id)
    }
    
    var name: String {
        return school.name
    }
    
    var phoneNumber: String {
        return school.phoneNumber
    }
    
    var email: String {
        return school.email ?? ""
    }
    
    var website: String {
        return school.website
    }
    
    var address: String {
        return school.addresLine + ", " + school.city + ", " + school.state + ", " + school.zip
    }
    
    var coordinate: CLLocationCoordinate2D? {
        guard let lat = Double(school.latitude), let long = Double(school.longitude) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var readingScore: String {
        return satScore?.readingScore ?? "N/A"
    }
    
    var writingScore: String {
        return satScore?.writingScore ?? "N/A"
    }
    
    var mathScore: String {
        return satScore?.mathScore ?? "N/A"
    }
    
    func toggleFavourite() {
        NYCDefaults.shared.toggleFavourite(id: school.id)
        isFavourite = NYCDefaults.shared.isFavorite(id: school.id)
    }
    
    //Fetching School Details
    func fetchSchoolDetails() {
        guard satScore == nil else { return }
        Task {
            do {
                let satScore = try await Network.shared.fetchSchoolsDetails(id: school.id)
                await setSATScore(satScore)
            } catch {
                await setSATScore(nil)
            }
        }
    }
    
    @MainActor
    func setSATScore(_ score: SATScore?) {
        self.satScore = score
    }
}

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
