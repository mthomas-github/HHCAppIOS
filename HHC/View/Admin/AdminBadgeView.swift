//
//  AdminBadgeView.swift
//  HHC
//
//  Created by Michael Thomas on 11/17/20.
//

import SwiftUI
import FASwiftUI

struct AdminBadgeView: View {
    let imageName: String
    let imageSize: CGFloat?
    let isLocked: Bool
    let title: String
    let description: String
    let buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction, label: {
            VStack {
                HStack(spacing: 15) {
                    FAText(iconName: imageName, size: imageSize ?? 50)
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .addVerifiedBadge(isLocked)
                    VStack(alignment: .leading) {
                        Text(title).font(.title)
                        Text(description)
                    } //: VSTACK
                    Spacer()
                } //: HSTACK
                Spacer()
            } //: VSTACK
            .padding()
        })
        .foregroundColor(.white)
    }
}

extension View {
    func addVerifiedBadge(_ isButtonLock: Bool) -> some View {
        ZStack(alignment: .topTrailing) {
            self
            if isButtonLock {
                Image(systemName: "lock.fill")
                
            }
        }
    }
}

struct AdminBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBadgeView(imageName: "users", imageSize: 30, isLocked: true, title: "Add Trip", description: "Add New Trip", buttonAction: {print("Test")})
    }
}
