
import SwiftUI

@available(iOS 14.0, OSX 11, *)
public struct Toastyle: View {
    
    // MARK: VARIABLES
    var text: String?
    @Binding var show: Bool
    @State private var visible: Bool = false
    @ObservedObject var state: ToastyleStateObj = ToastyleStateObj()
    
    // MARK: INIT
    public init(text: String? = nil, show: Binding<Bool>) {
        self.text = text
        self._show = show
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                HStack {
                    Image(systemName: alertIcon(state: state.state))
                        .font(Font.system(size: 18, weight: .semibold))
                        .foregroundColor(alertTextColor(state: state.state))
                    // MARK: IMAGE & TEXT
                    Text(text ?? "Default message")
                        .foregroundColor(alertTextColor(state: state.state))
                        .padding(.trailing, 4)
                }
                .padding(14)
                .padding(.horizontal, 6)
            }
            .background(
                // MARK: BACKGROUND
                Capsule()
                    .fill()
                    .shadow(color: Color.shadow, radius: 2, y: 1.2)
                    .foregroundColor(alertCardColor(state: state.state))
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
                // MARK: VISIBILITY
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
    
    // MARK: ICON TYPE
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

    // MARK: TEXT COLOR
    private func alertTextColor(state: ToastyleState) -> Color {
        return Color.black
    }

    // MARK: GET BG COLOR
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

// MARK: STATE ENUM
@available(iOS 14.0, OSX 11, *)
public enum ToastyleState {
    case info, success, failed, warning
}

// MARK: ICONS
@available(iOS 14.0, OSX 11, *)
public struct ToastyleIcon {
    
    static let info = "info.circle.fill"
    static let success = "checkmark.circle.fill"
    static let warning = "exclamationmark.triangle.fill"
    static let failed = "x.circle.fill"
    
}

// MARK: COLORS
@available(iOS 14.0, OSX 11, *)
public extension Color {
    static let alertWarning = getColor("alertWarning")
    static let alertFailed = getColor("alertFailed")
    static let alertInfo = getColor("alertInfo")
    static let alertSuccess = getColor("alertSuccess")
    static let dialogOverlay = getColor("dialogOverlay")
    static let shadow = getColor("shadow")
    
    private static func getColor(_ name: String) -> Color {
        return Color(name, bundle: .module)
    }
    
}

// MARK: MODELS
@available(iOS 14.0, OSX 11, *)
final class ToastyleStateObj: ObservableObject {
    var state: ToastyleState = .info
}


// MARK: EXTENSION
@available(iOS 14.0, OSX 11, *)
extension Toastyle {
    
    public func state(_ state: ToastyleState) -> Toastyle {
        self.state.state = state
        return self
    }
    
}


// MARK: PREVIEW
struct Toastyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Toastyle(text: "Example", show: .constant(true))
            
        }
        .background(Color.gray.opacity(0.1))
        
    }
}
