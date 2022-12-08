//
//  _9860706_veerababuMulugu_NYCSchoolsApp.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import SwiftUI

@main
struct _9860706_veerababuMulugu_NYCSchoolsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SchoolListViewModel())
        }
    }
}
