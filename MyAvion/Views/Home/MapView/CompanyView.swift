//
//  CompanyView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

struct CompanyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Sweet Dreams Tea Shop")
                    .font(.system(size: 20))
                Spacer()
                Text("150 m")
                    .font(.footnote)
                    .opacity(0.5)
            }
            
            Text("Earn 1.5x Avion points for every $1 spend.")
            
            HStack{
                Text("Food & Drink")
                    .padding(5)
                    .clipShape(.capsule)
                    .background(Capsule().stroke(lineWidth: 0.5))
                    .foregroundStyle(Color.red)
                Spacer()
                Image(systemName: "clock")
                    .foregroundStyle(Color.red)
                Text("2 days")
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.background))
        .shadow(radius: 3)
        
    }
}

#Preview {
    CompanyView()
}
