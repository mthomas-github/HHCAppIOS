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
    var body: some View {
            VStack {
                HStack(spacing: 15) {
                    FAText(iconName: imageName, size: imageSize ?? 50)
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .addVerifiedBadge(isLocked)
                        .foregroundColor(.white)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title)
                            .foregroundColor(.white)
                        Text(description)
                            .foregroundColor(.white)
                    } //: VSTACK
                    Spacer()
                } //: HSTACK
                Spacer()
            } //: VSTACK
            .padding()
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
        AdminBadgeView(imageName: "users", imageSize: 30, isLocked: true, title: "Add Trip", description: "Add New Trip")
    }
}
