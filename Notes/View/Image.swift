//
//  Image.swift
//  Notes
//
//  Created by Ben Stacy on 2/1/25.
//

import SwiftUI

struct ImageView: View {
    @State private var snapEffect: Bool = false
    @State private var isRemoved: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                if !isRemoved {
                    Group {
                        Image(.pic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipped()
                            
//                            .disintegrationEffect(isDeleted: snapEffect) {
//                                withAnimation(.snappy) {
//                                    isRemoved = true
//                                }
//                            }
                        
                        Button("Remove View") {
                            snapEffect = true
                        }
                    }
                }
            }
            .navigationTitle("Disintegration Effect")
        }
    }
}

#Preview {
    ImageView()
}
