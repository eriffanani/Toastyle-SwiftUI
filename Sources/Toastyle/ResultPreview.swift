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
                text: "This is toast message asdf asdf asd fas df asdf asd fa sdf as df as df ",
                //image: "iconExample",
                icon: "xmark",
                show: $show
            )
            .state(.info)
            .shadow(true)
            
        }
    }
    
}

struct ResultPreview_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview()
    }
}
