//
//  SchoolListViewModel.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import Combine
import Foundation

enum ScreenState {
    case loading
    case idle
    case empty
}

class SchoolListViewModel: ObservableObject {
    @Published var schools: [SchoolViewModel] = []
    @Published var state: ScreenState = .idle
    
    func searchSchools(searchText: String) {
        state = .loading
        Task {
            do {
                let schools = try await Network.shared.fetchSchools(searchText: searchText, offset: 0, limit: 10)
                await setSchoolsData(schools)
            } catch {
                await setSchoolsData([])
            }
        }
    }
    
    @MainActor
    func setSchoolsData(_ schools: [School]) {
        state = schools.isEmpty ? .empty : .idle
        self.schools = schools.map({ SchoolViewModel(school: $0) })
    }
}
