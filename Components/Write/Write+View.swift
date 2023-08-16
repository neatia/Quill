import Granite
import GraniteUI
import SwiftUI

extension Write: View {
    public var view: some View {
        VStack(spacing: 0) {
            HStack(spacing: .layer3) {
                Button {
                    GraniteHaptic.light.invoke()
                    importPicture()
                } label : {
                    Image(systemName: "rectangle.center.inset.filled.badge.plus")//"\(state.imageData != nil ? "photo" : "rectangle.center.inset.filled.badge.plus")")
                        .font(.title3)
                        .foregroundColor(.foreground)//state.imageData != nil ? .green : .foreground)
                        .opacity(1.0)//state.imageData != nil ? 0.8 : 1.0)
                }
                .buttonStyle(PlainButtonStyle())
                
                if let url = state.lastURL {
                    Spacer()
                    
                    Text("Last public url: ")
                    TextField("", text: .constant(url))
                        .font(.subheadline)
                        .textFieldStyle(.plain)
                }
                /*
                Toggle(isOn: _state.enableIPFS) {
                    Text("MISC_IPFS")
                        .font(.headline)
                        .offset(x: 0, y: Device.isMacOS ? -1 : 0)
                }
                .frame(width: Device.isMacOS ? 50 : 94)
                 */
                
                Spacer()
                
                Button {
                    GraniteHaptic.light.invoke()
                    center.create.send()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.headline)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .frame(height: 24)
            .padding(.leading, .layer4)
            .padding(.trailing, .layer4)
            .padding(.vertical, .layer4)
            
            Divider()
                .padding(.bottom, .layer2)
            
            WriteView(kind: self.kind,
                      title: _state.title,
                      content: _state.content)
        }
        .padding(.top, .layer4)
        .addGraniteSheet(modal.sheetManager, background: Color.clear)
        .addGraniteModal(modal.modalManager)
        .onAppear {
            #if os(iOS)
            UITextView.appearance().backgroundColor = .clear
            #endif
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
