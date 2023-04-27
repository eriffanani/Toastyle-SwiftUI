
import SwiftUI

@available(iOS 14.0, OSX 11, *)
public struct Toastyle: View {
    
    var state: ToastyleState
    var text: String?
    @Binding var show: Bool
    @State private var visible: Bool = false
    
    init(state: ToastyleState = .info, text: String? = nil, show: Binding<Bool>) {
        self.state = state
        self.text = text
        self._show = show
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                HStack {
                    Image(systemName: alertIcon(state: state))
                        .font(Font.system(size: 18, weight: .semibold))
                        .foregroundColor(alertTextColor(state: state))
                    
                    Text(text ?? "Default message")
                        .foregroundColor(alertTextColor(state: state))
                        .padding(.trailing, 4)
                }
                .padding(14)
                .padding(.horizontal, 6)
            }
            .background(
                Capsule()
                    .fill()
                    .shadow(color: Color.shadow, radius: 2, y: 1.2)
                    .foregroundColor(alertCardColor(state: state))
            )
            .padding(.bottom, 16)
            .animation(.linear(duration: 0.3))
            .onTapGesture {
                withAnimation {
                    visible = false
                }
                show = false
            }
            .opacity(visible ? 1 : 0)
            .onChange(of: show) { mShow in
                if !visible && mShow {
                    withAnimation {
                        visible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            visible = false
                        }
                        show = false
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func alertIcon(state: ToastyleState) -> String {
        switch state {
        case .warning:
            return ToastyleIcon.warning
        case .failed:
            return ToastyleIcon.failed
        case .success:
            return ToastyleIcon.success
        default:
            return ToastyleIcon.info
        }
    }

    private func alertTextColor(state: ToastyleState) -> Color {
        return Color.black
    }

    private func alertCardColor(state: ToastyleState) -> Color {
        switch state {
        case .failed:
            return Color.alertFailed
        case .warning:
            return Color.alertWarning
        case .success:
            return Color.alertSuccess
        default:
            return Color.alertInfo
        }
    }
    
}

struct Toastyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Toastyle(text: "Example", show: .constant(true))
            
        }
        .background(Color.gray.opacity(0.1))
        
    }
}
