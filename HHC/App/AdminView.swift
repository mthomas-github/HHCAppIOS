//
//  AdminView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import Amplify
import Combine
import SwiftUI

struct AdminView: View {
    @State var trips = [Trip]()
    
    @State var showNewTrip = false
    @State var observationToken: AnyCancellable?
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(trips) { trip in
                        Text(trip.name)
                    }
                    .onDelete(perform: deleteTrips)
                }
                
                VStack {
                    Spacer()
                    
                    Button(
                        action: { showNewTrip.toggle() },
                        label: {
                            Image(systemName: "plus")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                    )
                    Spacer()
                        .frame(height: 30)
                }
            }
            .navigationTitle("Trips")
            .sheet(isPresented: $showNewTrip) {
                NewTripView()
            }
        }
        .onAppear {
            getTrips()
        }
    }
    
    func getTrips() {
        Amplify.DataStore.query(Trip.self) { result in
            switch result {
            case .success(let trips):
                self.trips = trips
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteTrips(at indexSet: IndexSet) {
        print("Deleted item at \(indexSet)")
        var updatedTrips = trips
        updatedTrips.remove(atOffsets: indexSet)
        guard let trip = Set(updatedTrips).symmetricDifference(trips).first else { return }
        
        Amplify.DataStore.delete(trip) { result in
            switch result {
            case .success:
                print("Deleted trip")
            case .failure(let error):
                print("Could not delete trip - \(error)")
            }
        }
        
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
