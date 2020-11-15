//
//  DashboardView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import Combine
import SwiftUI

struct DashboardView: View {
    
    @State var trips = [Trip]()
    @State private var isShowingSettings: Bool = false
    @State private var isLoading = false
    @State var observationToken: AnyCancellable?
    @ObservedObject var sessionManager = SessionManager()
    
    
    var body: some View {
        NavigationView {
            List {
                if(trips.count >= 1) {
                CoverImageView(trips: trips)
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isShowingSettings = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                    } // : BUTTON
                    .sheet(isPresented: $isShowingSettings) {
                        SettingView()
                    }
            )
        } // : NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            getTrips()
            observeTrips()
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
    
    func observeTrips() {
        self.observationToken = Amplify.DataStore.publisher(for: Trip.self)
            .sink(receiveCompletion: { completion in
                //print("Subscription has been completed: \(completion)")
            }, receiveValue: { changes in
                //print("Subscription got this value: \(changes)")
                
                guard let trip = try? changes.decodeModel(as: Trip.self) else { return }
                switch changes.mutationType {
                case "create":
                    print("Created")
                case "delete":
                    if let index = self.trips.firstIndex(of: trip) {
                        self.trips.remove(at: index)
                    }
                default:
                    break
                }
            })
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .previewDevice("iPhone 11 Pro")
            .preferredColorScheme(.dark)
    }
}
