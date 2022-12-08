//
//  SchoolTileView.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import SwiftUI

struct SchoolTileView: View {
    
    @EnvironmentObject var viewModel: SchoolViewModel
    
    @State private var showSchoolDetails: Bool = false
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.name)
                        .font(.callout)
                        .bold()
                    Text(viewModel.address)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(viewModel.website)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: {
                    viewModel.toggleFavourite()
                }, label: {
                    Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(.red)
                })
            }.onTapGesture {
                showSchoolDetails = true
            }
            NavigationLink(
                destination:
                    SchoolDetailsView()
                    .environmentObject(viewModel)
                ,
                isActive: $showSchoolDetails,
                label: {
                    EmptyView()
                })
        }
        .padding(10)
        .frame(height: 100)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 5)
    }
}

struct SchoolTileView_Previews: PreviewProvider {
    static var previews: some View {
        let eventVM = SchoolViewModel(school: School.fake)
        return Group {
            SchoolTileView()
                .previewLayout(.sizeThatFits)
                .environmentObject(eventVM)
        }
    }
}
