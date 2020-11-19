//
//  AdminTripListView.swift
//  HHC
//
//  Created by Michael Thomas on 11/17/20.
//

import SwiftUI
import Combine
import Amplify

struct AdminTripListView: View {
    @State var trips = [Trip]()
    @State var showNewTrip = false
    @State var observationToken: AnyCancellable?
    @State private var editMode = EditMode.inactive
    @State private var isShowingSettings: Bool = false
    
    private static var count = 0
    var body: some View {
        List {
            if(trips.count >= 1) {
                ForEach(trips) { trip in
                    NavigationLink(destination: TripDetailView(trip: trip)) {
                        TripListItemView(trip: trip)
                    } // : LINK
                } // : LOOP
            } else {
                Text("No Trips")
            }
        } // : LIST
        .navigationTitle("Trips")
        .onAppear {
            getTrips()
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    
    private func onDelete(offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        trips.move(fromOffsets: source, toOffset: destination)
    }
    
    func onAdd() {
        
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

struct AdminTripListView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTripListView()
    }
}
