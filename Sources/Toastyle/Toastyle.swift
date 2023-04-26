
import SwiftUI

struct Toastyle: View {
    
    var state: ToastState
    var text: String?
    @Binding var show: Bool
    
    init(state: ToastState = .info, text: String? = nil, show: Binding<Bool>) {
        self.state = state
        self.text = text
        self._show = show
    }
    
    var body: some View {
        VStack {
            Spacer()
            if show {
                ZStack {
                    Capsule()
                        .fill()
                        .shadow(color: Color.shadow, radius: 2, y: 1.2)
                        .foregroundColor(alertCardColor(state: state))
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
                .fixedSize(horizontal: true, vertical: true)
                .padding(.bottom, 16)
                .animation(.easeInOut(duration: 0.2))
                .transition(AnyTransition.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.show = false
                        }
                    }
                }
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

func alertIcon(state: ToastState) -> String {
    switch state {
    case .warning:
        return Icons.warning
    case .failed:
        return Icons.failed
    case .success:
        return Icons.success
    default:
        return Icons.info
    }
}

func alertTextColor(state: ToastState) -> Color {
    return Color.black
}

func alertCardColor(state: ToastState) -> Color {
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

enum ToastState {
    case info, success, failed, warning
}

struct Toastyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Toastyle(state: .info, show: .constant(true))
            
        }
        .background(Color.gray.opacity(0.1))
        
    }
}
