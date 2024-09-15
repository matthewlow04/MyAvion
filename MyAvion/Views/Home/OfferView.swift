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
                
                AsyncImage(url: URL(string: "https://mma.prnewswire.com/media/2143484/Lazeez_Lazeez_Shawarma_Celebrates_10th_Anniversary_and_Gives_Out.jpg?w=400")) { image in
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
                Text("BillGong")
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

