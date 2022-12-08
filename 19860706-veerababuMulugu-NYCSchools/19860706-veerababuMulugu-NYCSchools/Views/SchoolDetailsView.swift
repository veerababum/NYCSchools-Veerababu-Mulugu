//
//  SchoolDetailsView.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import MapKit
import SwiftUI

struct SchoolDetailsView: View {
    
    @EnvironmentObject var viewModel: SchoolViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.name)
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    viewModel.toggleFavourite()
                }, label: {
                    Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(.red)
                })
            }
            
            VStack(alignment: .leading) {
                Text(viewModel.address)
                    .font(.subheadline)
                Text(viewModel.phoneNumber)
                    .font(.subheadline)
                Text(viewModel.email)
                    .font(.subheadline)
                Text(viewModel.website)
                    .font(.subheadline)
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text("SAT Scores")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                HStack {
                    Text("Reading")
                    Spacer()
                    Text("Writing")
                    Spacer()
                    Text("Math")
                        .font(.subheadline)
                    
                }
                .frame(maxWidth: .infinity)
                HStack() {
                    Text(viewModel.readingScore)
                        .font(.body)
                    Spacer()
                    Text(viewModel.writingScore)
                        .font(.body)
                    Spacer()
                    Text(viewModel.mathScore)
                        .font(.body)
                }
                .frame(maxWidth: .infinity)
                
                if let coordinate = viewModel.coordinate {
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate,
                                                                      span: MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1))),
                                annotationItems: [IdentifiablePlace(lat: coordinate.latitude, long: coordinate.longitude)])
                            { place in
                                MapMarker(coordinate: place.location,
                                       tint: Color.purple)
                            }
                }
            }
            
         
            
            
            Spacer()
        }
        .onAppear(perform: {
            viewModel.fetchSchoolDetails()
        })
        .padding()
        .navigationBarHidden(false)
        .navigationTitle("SAT Score")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SchoolDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let eventVM = SchoolViewModel(school: School.fake)
        eventVM.satScore = SATScore.fake
        return SchoolDetailsView()
            .environmentObject(eventVM)
    }
}
