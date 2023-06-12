//
//  SwiftUIView.swift
//  
//
//  Created by ok fits on 26/04/23.
//

import SwiftUI

struct ResultPreview: View {
    
    @State private var show: Bool = false
    
    @State private var value: Int = 0
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 15) {
                
                Button {
                    value = 1
                } label: {
                    Text("Change State")
                }
                
                Button {
                    show = true
                } label: {
                    Text("Show Toast !!")
                }
                
            }
            
            Toastyle(
                text: "This is toast message ",
                //image: "iconExample",
                //icon: "xmark",
                show: $show
            )
            
        }
    }
    
}

struct ResultPreview_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview()
    }
}
