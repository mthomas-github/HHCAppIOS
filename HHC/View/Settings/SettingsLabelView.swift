//
//  SettingsLabelView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct SettingsLabelView: View {
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Heritage Hiking", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
