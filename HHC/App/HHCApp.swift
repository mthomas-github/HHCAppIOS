//
//  HHCApp.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//
import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct HHCApp: App {
    @ObservedObject var sessionManager = SessionManager()
    
    // add a default initializer and configure Amplify
    public init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
        sessionManager.observeAuthEvents()
    }
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)
            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)
            case .session(let user):
                ContentView(user: user)
                    .environmentObject(sessionManager)
            }
        }
    }
    
    func configureAmplify() {
        do {
            // Storage
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            // Datastore
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            
            // Configure Plugins
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            // simplified error handling for the tutorial
            print("Could not initialize Amplify: \(error)")
        }
    }
}
