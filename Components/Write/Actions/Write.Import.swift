//
//  Write.Import.swift
//  Quill (iOS)
//
//  Created by PEXAVC on 7/21/23.
//

import Foundation
import SwiftUI
import IPFSKit
#if os(macOS)
import AppKit

extension Write {
    func importPicture() {
        //TODO: gallery of imports?
//        if let data = state.imageData,
//           let image = NSImage(data: data) {
//            modal.present(GraniteAlertView(title: "Modify") {
//                GraniteAlertAction {
//                    PhotoView(image: image)
//                        .frame(minWidth: Device.isMacOS ? 400 : nil, minHeight: Device.isMacOS ? 400 : nil)
//                }
//
//                GraniteAlertAction(title: "Replace") {
//                    _importPicture()
//                }
//                GraniteAlertAction(title: "Remove", kind: .destructive) {
//                    _state.imageData.wrappedValue = nil
//                }
//                GraniteAlertAction(title: "Cancel")
//            }
//            )
//        } else {
//            _importPicture()
//        }
        _importPicture()
    }
    func _importPicture() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.allowedContentTypes = [.image, .gif]
        if panel.runModal() == .OK {
            if let url = panel.url {
                
                if let data = try? Data(contentsOf: url) {
                    self.setIPFSImage(data)
                }
            }
        }
    }
}

#else
import PhotosUI
extension Write {
    func importPicture() {
        modal.presentSheet {
            ImagePicker(imageData: _state.imageData)
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var imageData: Data?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async { [weak self] in
                        if let data = (image as? UIImage)?.png {
                            self.setIPFSImage(data)
                        }
                    }
                }
            }
        }
    }
}
#endif

extension Write {
    func setIPFSImage(_ data: Data) {
        _ = Task {
            let response = await IPFS.upload(data)
            
            
            guard let ipfsURL = IPFSKit.gateway?.genericURL(for: response) else {
                return
            }
            
            _state.content.wrappedValue += "\n\n![Image](\(ipfsURL.absoluteString))"
        }
    }
}
