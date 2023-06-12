//
//  SwiftUIView.swift
//  
//
//  Created by Erif Fanani on 12/06/23.
//

import SwiftUI

struct ItemView: View {
    var idx: Int
    var title: String
    var onClick: (Int) -> Void
    
    var body: some View {
        Button {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                onClick(idx+1)
            }
        } label: {
            LazyVStack(spacing: 0) {
                
                Divider()
                    .overlay(Color("colorDivider"))
                    .opacity(idx == 0 ? 0 : 1)
                
                HStack {
                    Text(title)
                        .foregroundColor(Color("titleList", bundle: .module))
                        .font(Font.system(size: 18))
                        .padding(.vertical, 20)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 8)
                        .font(Font.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.3))
                }
                .padding(.horizontal, 10)
            }
        }
        .buttonStyle(ButtonTap())
    }
    
    private struct ButtonTap: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .contentShape(Rectangle())
                .background(configuration.isPressed ? Color("pressed") : Color.clear)
        }
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(
            idx: -1, title: "This is title"
        ) { idx in
            
        }
    }
}
