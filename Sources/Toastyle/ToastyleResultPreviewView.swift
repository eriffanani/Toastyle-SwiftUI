//
//  SwiftUIView.swift
//  
//
//  Created by ok fits on 26/04/23.
//

import SwiftUI

struct ToastyleResultPreviewView: View {
    
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            
            Button {
                show = true
            } label: {
                Text("Klik Me")
            }
            
            Toastyle(state: .failed, text: "Ini adalah toast", show: $show)
            
        }
    }
}

struct ToastyleResultPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ToastyleResultPreviewView()
    }
}
