//
//  OfferView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

struct OfferView: View {
    var body: some View {
        VStack{
            ZStack(alignment:.topLeading){
                AsyncImage(url: URL(string: "https://cdn.prod.website-files.com/630d4d1c4a462569dd189855/64e67dfb31929f572b21d128_2%20(1).webp")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 120)
                        .clipped()
                        
                } placeholder: {
                    ProgressView()
                        .scaledToFill()
                        .frame(width: 300, height: 120)
                        .clipped()
                }
                
                .frame(height: 120)
                
                AsyncImage(url: URL(string: "data:image/png;base64,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")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 50)
                        .clipped()
                        
                } placeholder: {
                    Color.gray.opacity(0.7)
                        .scaledToFill()
                        .frame(width: 100, height: 50)
                        .clipped()
                }
                
                .frame(width: 100, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()

            }
            
            VStack(alignment: .leading, spacing: 10){
                Text("Aritzia")
                    .font(.system(size: 18))
                Text("Earn 2x Avion points when you shop at Aritzia, only for you")
                    .font(.system(size: 13))
                HStack{
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.red)
                    Text("2 days")
                }
                .font(.system(size: 13))
              
            }
            .frame(height: 100)
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.background))
        .shadow(radius: 5)
        .frame(width: 300)
    }
}

#Preview {
    OfferView()
}

