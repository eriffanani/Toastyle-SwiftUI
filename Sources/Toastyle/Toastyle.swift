
import SwiftUI

@available(iOS 14.0, OSX 11, *)
public struct Toastyle: View {
    
    // MARK: VARIABLES
    var text: String?
    var icon: String?
    var image: String?
    @Binding var show: Bool
    @State private var visible: Bool = false
    @ObservedObject var state: ToastyleStateObj = ToastyleStateObj()
    @State private var scale: CGFloat = 0.2
    
    // MARK: INIT
    public init(text: String? = nil, show: Binding<Bool>) {
        self.text = text
        self.icon = nil
        self.image = nil
        self._show = show
    }
    
    public init(text: String? = nil, icon: String? = nil, show: Binding<Bool>) {
        self.text = text
        self.icon = icon
        self.image = nil
        self._show = show
    }
    
    public init(text: String? = nil, image: String? = nil, show: Binding<Bool>) {
        self.text = text
        self.icon = nil
        self.image = image
        self._show = show
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                let iconColor: Color = alertIconColor(state: state)
                if let mIcon = icon {
                    Image(systemName: mIcon)
                        .font(Font.system(size: 22, weight: .semibold))
                        .foregroundColor(iconColor)
                } else if let mImage = image {
                    Image(mImage)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(iconColor)
                        .frame(width: 28)
                } else {
                    Image(systemName: alertIcon(state: state.state))
                        .font(Font.system(size: 22, weight: .semibold))
                        .foregroundColor(iconColor)
                }
                
                // MARK: IMAGE & TEXT
                Text(text ?? "Default message")
                    .foregroundColor(alertTextColor(state: state))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(
                // MARK: BACKGROUND
                backgroundShape(state: state)
            )
            .padding(.bottom, 16)
            .onTapGesture {
                withAnimation {
                    visible = false
                }
                show = false
            }
            .opacity(visible ? 1 : 0)
            .scaleEffect(scale, anchor: .center)
            .onChange(of: show) { mShow in
                // MARK: VISIBILITY
                if !visible && mShow {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        visible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            visible = false
                        }
                        show = false
                    }
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                        scale = 1
                    }
                } else {
                    withAnimation {
                        scale = 0.2
                    }
                }
            }
        }
        .padding(.horizontal, 15)
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
    
    // MARK: ICON Color
    private func alertIconColor(state: ToastyleStateObj) -> Color {
        switch state.state {
        case .warning:
            return Color.iconWarning
        case .failed:
            return Color.iconFailed
        case .success:
            return Color.iconSuccess
        case .info:
            return Color.iconInfo
        default:
            return state.iconColor
        }
    }

    // MARK: TEXT COLOR
    private func alertTextColor(state: ToastyleStateObj) -> Color {
        switch(state.state) {
        case .plain:
            return state.textColor
        default:
            return Color.black
        }
    }

    // MARK: GET BG COLOR
    private func alertCardColor(state: ToastyleStateObj) -> Color {
        switch state.state {
        case .failed:
            return Color.alertFailed
        case .warning:
            return Color.alertWarning
        case .success:
            return Color.alertSuccess
        case .info:
            return Color.alertInfo
        default:
            return state.backgroundColor
        }
    }
    
    @ViewBuilder
    private func backgroundShape(state: ToastyleStateObj) -> some View {
        if state.cornerRadius > 0 {
            RoundedRectangle(
                cornerRadius: state.cornerRadius
            )
            .fill(alertCardColor(state: state))
            .shadow(color: Color.shadow, radius: state.shadow ? 2 : 0, y: state.shadow ? 1.2 : 0)
        } else if !state.corners.isEmpty {
            ToastyleBackground2(
                radius: state.cornersValue,
                corners: state.corners
            )
            .fill(alertCardColor(state: state))
            .shadow(color: Color.shadow, radius: state.shadow ? 2 : 0, y: state.shadow ? 1.2 : 0)
        } else {
            ToastyleBackground(
                tl: state.topLeftRadius,
                tr: state.topRightRadius,
                bl: state.bottomLeftRadius,
                br: state.bottomRightRadius
            )
            .fill(alertCardColor(state: state))
            .shadow(color: Color.shadow, radius: state.shadow ? 2 : 0, y: state.shadow ? 1.2 : 0)
        }
    }
    
}

// MARK: STATE ENUM
@available(iOS 14.0, OSX 11, *)
public enum ToastyleState {
    case plain, info, success, failed, warning
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
    static let alertPlain = getColor("alertPlain")
    
    static let iconSuccess = getColor("iconSuccess")
    static let iconFailed = getColor("iconFailed")
    static let iconInfo = getColor("iconInfo")
    static let iconWarning = getColor("iconWarning")
//    static let alertPlain = getColor("alertPlain")
    
    static let dialogOverlay = getColor("dialogOverlay")
    static let shadow = getColor("shadow")
    
    private static func getColor(_ name: String) -> Color {
        return Color(name, bundle: .module)
    }
    
}

// MARK: MODELS
@available(iOS 14.0, OSX 11, *)
final class ToastyleStateObj: ObservableObject {
    var state: ToastyleState = .plain
    var textColor: Color = .white
    var backgroundColor: Color = .alertPlain
    var iconColor: Color = .white
    var cornerRadius: CGFloat = 22
    var corners: UIRectCorner = []
    var cornersValue: CGFloat = 0
    var topLeftRadius: CGFloat = 0
    var topRightRadius: CGFloat = 0
    var bottomLeftRadius: CGFloat = 0
    var bottomRightRadius: CGFloat = 0
    var shadow: Bool = false
}


// MARK: EXTENSION
@available(iOS 14.0, OSX 11, *)
extension Toastyle {
    
    public func state(_ state: ToastyleState) -> Toastyle {
        self.state.state = state
        return self
    }
    
    public func textColor(_ color: Color) -> Toastyle {
        self.state.textColor = color
        return self
    }
    
    public func backgroundColor(_ color: Color) -> Toastyle {
        self.state.backgroundColor = color
        return self
    }
    
    public func iconColor(_ color: Color) -> Toastyle {
        self.state.iconColor = color
        return self
    }
    
    public func shadow(_ shadow: Bool) -> Toastyle {
        self.state.shadow = shadow
        return self
    }
    
    public func corner(_ radius: CGFloat) -> Toastyle {
        self.state.cornerRadius = radius
        return self
    }
    
    public func corners(_ radius: CGFloat, corners: UIRectCorner) -> Toastyle {
        self.state.cornersValue = radius
        self.state.cornerRadius = 0
        self.state.corners = corners
        return self
    }
    
    public func topLeftRadius(_ radius: CGFloat) -> Toastyle {
        self.state.topLeftRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    public func topRightRadius(_ radius: CGFloat) -> Toastyle {
        self.state.topRightRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    public func bottomLeftRadius(_ radius: CGFloat) -> Toastyle {
        self.state.bottomLeftRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    public func bottomRightRadius(_ radius: CGFloat) -> Toastyle {
        self.state.bottomRightRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
}


// MARK: PREVIEW
struct Toastyle_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview()
    }
}
