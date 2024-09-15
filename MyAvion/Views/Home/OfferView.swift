//
//  OfferView.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-14.
//

import SwiftUI

struct OfferView: View {
    var logo: String
    var image: String
    var name: String
    var description: String
    var time: String
    var body: some View {
        VStack{
            ZStack(alignment:.topLeading){
                AsyncImage(url: URL(string: image)) { image in
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
                
                AsyncImage(url: URL(string: logo)) { image in
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
                Text(name)
                    .font(.system(size: 18))
                Text(description)
                    .font(.system(size: 13))
                HStack{
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.red)
                    Text(time)
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


