//
//  SmallAddButton.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/18/22.
//

import SwiftUI

struct SmallAddButton: View {
    var body: some View {
        ZStack {//working on z axis, each element will be on top of another
            Circle()
                .frame(width: 50)
                .foregroundColor(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
        .frame(width: 50)
    }
}

struct SmallAddButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallAddButton()
    }
}
