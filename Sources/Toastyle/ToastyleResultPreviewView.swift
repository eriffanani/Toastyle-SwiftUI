//
//  SwiftUIView.swift
//  
//
//  Created by ok fits on 26/04/23.
//

import SwiftUI

struct ToastyleResultPreviewView: View {
    
    @State private var show: Bool = false
    
    @State private var value: Int = 0
    
    var body: some View {
        ZStack {
            
            Button {
                value = 1
                show = true
            } label: {
                Text("Show Toast !!")
            }
            
            Toastyle(
                text: "This is toast message",
                show: $show
            )
            .state(value == 0 ? .warning : .success)
            
        }
    }
}

struct ToastyleResultPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ToastyleResultPreviewView()
    }
}
