//
//  ContentView.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    @EnvironmentObject var viewModel : SchoolListViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading)  {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading")
                case .idle:
                    schoolsView
                    Spacer()
                case .empty:
                    Text("No Schools found")
                }
            }
            .navigationTitle("NewYork Schools")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                searchSchools(for: searchText)
            }
            
            .onAppear(perform: {
                self.searchSchools(for: searchText)
            })
        }
    }
    
    @ViewBuilder
    var schoolsView: some View {
        ScrollView {
            VStack(alignment: .leading)  {
                ForEach(viewModel.schools) { schoolVM in
                    SchoolTileView()
                        .environmentObject(schoolVM)
                }
            }
            .padding()
        }
    }
    
    func searchSchools(for searchText: String) {
        viewModel.searchSchools(searchText: searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SchoolListViewModel()
        vm.schools = [SchoolViewModel(school: School.fake)]
        return ContentView()
            .environmentObject(vm)
    }
}
