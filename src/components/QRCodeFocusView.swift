import SwiftUI

/// A View representing the 4 corners focusing on the QR code
struct QRCodeFocusView: View {
    let size: CGFloat
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                QRCodeFocusCornerView(corner: .topLeft, size: 20, cornerRadius: 5)
                Spacer()
                QRCodeFocusCornerView(corner: .topRight, size: 20, cornerRadius: 5)
            }
            Spacer()
            HStack(alignment: .center) {
                QRCodeFocusCornerView(corner: .bottomLeft, size: 20, cornerRadius: 5)
                Spacer()
                QRCodeFocusCornerView(corner: .bottomRight, size: 20, cornerRadius: 5)
            }
        }
        .frame(width: size, height: size)
    }
}

struct QRCodeFocusCornerView: View {
    enum Corner {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    let corner: Corner
    let size: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(.gray, lineWidth: 2.0)
        .frame(width: size * 2, height: size * 2)
        .clipShape(PositionedClipShape(
            offsetX: [.topLeft, .bottomLeft].contains(corner) ? -size : size,
            offsetY: [.topLeft, .topRight].contains(corner) ? -size : size)
        )
    }
        
    private struct PositionedClipShape: Shape {
        let offsetX: CGFloat
        let offsetY: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let targetRect = CGRect(x: offsetX, y: offsetY, width: rect.width, height: rect.height)
            path.addRect(targetRect)
            return path
        }
    }
}

#Preview {
    ZStack(alignment: .center) {
        QRCodeFocusView(size: 100)
        // Mocked QR Code at the center of the Focus View
        Rectangle()
        .fill(.gray)
        .frame(width: 80, height: 80)
        Text("QR Code").foregroundColor(.white)
    }
}
