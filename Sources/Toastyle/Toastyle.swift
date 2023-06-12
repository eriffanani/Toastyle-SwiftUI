
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
    
    private let defaultMessage: String = "Default message"
    
    // MARK: INIT BASIC
    public init(text: String? = nil, show: Binding<Bool>) {
        self.text = text
        self.icon = nil
        self.image = nil
        self._show = show
    }
    
    // MARK: INIT ICON
    public init(text: String? = nil, icon: String? = nil, show: Binding<Bool>) {
        self.text = text
        self.icon = icon
        self.image = nil
        self._show = show
    }
    
    // MARK: INIT IMAGE
    public init(text: String? = nil, image: String? = nil, show: Binding<Bool>) {
        self.text = text
        self.icon = nil
        self.image = image
        self._show = show
    }
    
    public var body: some View {
        VStack {
            if state.position == .center || state.position == .bottom {
                Spacer()
            }
            
            HStack(spacing: 0) {
                
                if state.position == .trailing {
                    Spacer()
                }
                
                HStack {
                    // MARK: ICON LEFT
                    let iconColor: Color = alertIconColor(state: state)
                    if state.iconPosition == .left {
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
                            if state.state != .plain {
                                if icon == nil && image == nil {
                                    Image(systemName: alertIcon(state: state.state))
                                        .font(Font.system(size: 22, weight: .semibold))
                                        .foregroundColor(iconColor)
                                }
                            }
                        }
                    }
                    
                    // MARK: TEXT
                    if let customFont = state.font {
                        Text(text ?? defaultMessage)
                            .foregroundColor(alertTextColor(state: state))
                            .font(customFont)
                    } else {
                        Text(text ?? defaultMessage)
                            .foregroundColor(alertTextColor(state: state))
                    }
                    
                    if state.iconPosition == .right {
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
                            // MARK: ICON RIGHT
                            if state.state != .plain {
                                if icon == nil && image == nil {
                                    Image(systemName: alertIcon(state: state.state))
                                        .font(Font.system(size: 22, weight: .semibold))
                                        .foregroundColor(iconColor)
                                }
                            }
                        }
                    }
                    
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(
                    // MARK: BACKGROUND
                    backgroundShape(state: state)
                        .overlay(borderShape(state: state))
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
                
                if state.position == .leading {
                    Spacer()
                }
                
            }
            
            if state.position == .center || state.position == .top {
                Spacer()
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
    
    // MARK: BACKGROUND
    @ViewBuilder
    private func backgroundShape(state: ToastyleStateObj) -> some View {
        let useShadow = state.shadow && state.borderSize == 0
        if state.cornerRadius > 0 {
            RoundedRectangle(
                cornerRadius: state.cornerRadius
            )
            .fill(alertCardColor(state: state))
            .shadow(color: Color.shadow, radius: useShadow ? 2 : 0, y: useShadow ? 1.2 : 0)
        } else if !state.corners.isEmpty {
            ToastyleBackground2(
                radius: state.cornersValue,
                corners: state.corners
            )
            .fill(alertCardColor(state: state))
            .shadow(color: Color.shadow, radius: useShadow ? 2 : 0, y: useShadow ? 1.2 : 0)
        } else {
            ToastyleBackground(
                tl: state.topLeftRadius,
                tr: state.topRightRadius,
                bl: state.bottomLeftRadius,
                br: state.bottomRightRadius
            )
            .fill(alertCardColor(state: state))
            .shadow(color: Color.shadow, radius: state.shadow ? 2 : 0, y: useShadow ? 1.2 : 0)
        }
    }
    
    // MARK: BORDER
    @ViewBuilder
    private func borderShape(state: ToastyleStateObj) -> some View {
        let defaultColor = alertIconColor(state: state)
        let color = state.borderColor ?? defaultColor
        if state.cornerRadius > 0 {
            RoundedRectangle(
                cornerRadius: state.cornerRadius
            )
            .stroke(color, lineWidth: state.borderSize)
        } else if !state.corners.isEmpty {
            ToastyleBackground2(
                radius: state.cornersValue,
                corners: state.corners
            )
            .stroke(color, lineWidth: state.borderSize)
        } else {
            ToastyleBackground(
                tl: state.topLeftRadius,
                tr: state.topRightRadius,
                bl: state.bottomLeftRadius,
                br: state.bottomRightRadius
            )
            .stroke(color, lineWidth: state.borderSize)
        }
    }
    
}

// MARK: STATE ENUM
@available(iOS 14.0, OSX 11, *)
public enum ToastyleState {
    case plain, info, success, failed, warning
}

@available(iOS 14.0, OSX 11, *)
public enum ToastyleIconPosition {
    case left, right
}

@available(iOS 14.0, OSX 11, *)
public enum ToastylePosition {
    case leading, top, trailing, bottom, center
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
    
    static let dialogOverlay = getColor("dialogOverlay")
    static let shadow = getColor("shadow")
    
    static let title = getColor("title")
    
    private static func getColor(_ name: String) -> Color {
        return Color(name, bundle: .module)
    }
    
}

// MARK: MODELS
@available(iOS 14.0, OSX 11, *)
final class ToastyleStateObj: ObservableObject {
    var state: ToastyleState = .plain
    var textColor: Color = .title
    var backgroundColor: Color = .alertPlain
    var iconColor: Color = .title
    var cornerRadius: CGFloat = 0
    var corners: UIRectCorner = []
    var cornersValue: CGFloat = 0
    var topLeftRadius: CGFloat = 0
    var topRightRadius: CGFloat = 0
    var bottomLeftRadius: CGFloat = 0
    var bottomRightRadius: CGFloat = 0
    var shadow: Bool = false
    var iconPosition: ToastyleIconPosition = .left
    var borderSize: CGFloat = 0
    var borderColor: Color? = nil
    var font: Font? = nil
    var position: ToastylePosition = .bottom
}


// MARK: EXTENSION
@available(iOS 14.0, OSX 11, *)
extension Toastyle {
    
    // State
    public func state(_ state: ToastyleState) -> Toastyle {
        self.state.state = state
        if state != .plain {
            self.state.cornerRadius = 22
        }
        return self
    }
    
    // Text Color
    public func textColor(_ color: Color) -> Toastyle {
        self.state.textColor = color
        return self
    }
    
    // Background Color
    public func backgroundColor(_ color: Color) -> Toastyle {
        self.state.backgroundColor = color
        return self
    }
    
    // Icon Color
    public func iconColor(_ color: Color) -> Toastyle {
        self.state.iconColor = color
        return self
    }
    
    // Shadow
    public func shadow(_ shadow: Bool) -> Toastyle {
        self.state.shadow = shadow
        return self
    }
    
    // Corner
    public func corner(_ radius: CGFloat) -> Toastyle {
        self.state.cornerRadius = radius
        return self
    }
    
    // Corners
    public func corners(_ radius: CGFloat, corners: UIRectCorner) -> Toastyle {
        self.state.cornersValue = radius
        self.state.cornerRadius = 0
        self.state.corners = corners
        return self
    }
    
    // Corner Top Left
    public func topLeftRadius(_ radius: CGFloat) -> Toastyle {
        self.state.topLeftRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    // Corner Top Right
    public func topRightRadius(_ radius: CGFloat) -> Toastyle {
        self.state.topRightRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    // Corner Bottom Left
    public func bottomLeftRadius(_ radius: CGFloat) -> Toastyle {
        self.state.bottomLeftRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    // Corner Bottom Right
    public func bottomRightRadius(_ radius: CGFloat) -> Toastyle {
        self.state.bottomRightRadius = radius
        self.state.cornerRadius = 0
        return self
    }
    
    // Icon Position
    public func iconPosition(_ position: ToastyleIconPosition) -> Toastyle {
        self.state.iconPosition = position
        return self
    }
    
    // Border
    public func border(_ size: CGFloat, color: Color? = nil) -> Toastyle {
        self.state.borderSize = size
        self.state.borderColor = color
        return self
    }
    
    public func font(font: Font?) -> Toastyle {
        self.state.font = font
        return self
    }
    
    public func position(position: ToastylePosition) -> Toastyle {
        self.state.position = position
        return self
    }
    
}

// MARK: PREVIEW
struct Toastyle_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview()
    }
}
// Dark
struct ToastyleDark_Previews: PreviewProvider {
    static var previews: some View {
        ResultPreview()
            .preferredColorScheme(.dark)
    }
}
