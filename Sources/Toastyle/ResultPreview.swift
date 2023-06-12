//
//  SwiftUIView.swift
//  
//
//  Created by ok fits on 26/04/23.
//

import SwiftUI

struct ResultPreview: View {
    
    private let titles: [String] = [
        "Basic", "Text Color", "Icon Left", "Icon Right", "With Border",
        "Corner Radius", "Corner Radius (Custom)", "Background Color",
        "Custom Font", "With State", "Shadow", "Position"
    ]
    
    @State private var show1: Bool = false
    @State private var show2: Bool = false
    @State private var show3: Bool = false
    @State private var show4: Bool = false
    @State private var show5: Bool = false
    @State private var show6: Bool = false
    @State private var show7: Bool = false
    @State private var show8: Bool = false
    @State private var show9: Bool = false
    @State private var show10: Bool = false
    @State private var show11: Bool = false
    @State private var show12: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<titles.count, id: \.self) { idx in
                            ItemView(
                                idx: idx, title: titles[idx]
                            ) { mIndex in
                                switch (mIndex) {
                                case 2:
                                    show2.toggle()
                                case 3:
                                    show3.toggle()
                                case 4:
                                    show4.toggle()
                                case 5:
                                    show5.toggle()
                                case 6:
                                    show6.toggle()
                                case 7:
                                    show7.toggle()
                                case 8:
                                    show8.toggle()
                                case 9:
                                    show9.toggle()
                                case 10:
                                    show10.toggle()
                                case 11:
                                    show11.toggle()
                                case 12:
                                    show12.toggle()
                                default:
                                    show1.toggle()
                                }
                            }
                        }
                    }
                    
                }
                
                Group {
                    toast1
                    toast2
                    toast3
                    toast4
                    toast5
                    Group {
                        toast6
                        toast7
                        toast8
                        toast9
                        toast10
                        toast11
                        toast12
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Toast Message")
        }
    }
    
    // Toast 1 Basic
    private var toast1: some View {
        Toastyle(text: "Basic Toast", show: $show1)
    }
    
    // Toast 2 Text Color
    private var toast2: some View {
        Toastyle(text: "Text Color Toast", show: $show2)
            .textColor(Color.yellow)
    }
    
    // Toast 3 Icon Left
    private var toast3: some View {
        Toastyle(text: "Icon Left Toast", icon: "info.circle.fill", show: $show3)
    }
    
    // Toast 4 Icon Right
    private var toast4: some View {
        Toastyle(text: "Icon Right Toast", icon: "info.circle.fill", show: $show4)
            .iconColor(Color.yellow)
            .iconPosition(.right)
    }
    
    // Toast 5 Border
    private var toast5: some View {
        Toastyle(text: "Bordered Toast Message", show: $show5)
            .border(3, color: Color.orange)
    }
    
    // Toast 6 Corner
    private var toast6: some View {
        Toastyle(text: "Toast Corner Radius", show: $show6)
            .corner(22)
    }
    
    // Toast 7 Corner Custom
    private var toast7: some View {
        Toastyle(text: "Custom Corner Radius", show: $show7)
            .corners(15, corners: [.topRight, .bottomLeft])
            .border(3, color: Color.pink)
    }
    
    // Toast 8 Background
    private var toast8: some View {
        Toastyle(text: "Backgrund Color", show: $show8)
            .corners(15, corners: [.topRight, .bottomLeft])
            .border(3, color: Color.yellow)
            .backgroundColor(Color.red)
    }
    
    // Toast 9 Font
    private var toast9: some View {
        Toastyle(text: "Custom Font Family", show: $show9)
            .corner(10)
            .font(font: .custom("Sunlit Memories", size: 20).bold())
    }
    
    // Toast 10 State
    private var toast10: some View {
        Toastyle(text: "Success State Toast", show: $show10)
            .state(.success)
    }
    
    // Toast 11 Shadow
    private var toast11: some View {
        Toastyle(text: "Shadow Warning State", show: $show11)
            .state(.warning)
            .shadow(true)
    }
    
    // Toast 12 Shadow
    private var toast12: some View {
        Toastyle(text: "Custom Position", show: $show12)
            .state(.info)
            .shadow(true)
            .position(position: .top)
            .padding(.top, 10)
    }
    
}

struct ResultPreview_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview()
    }
}
