import Granite
import IPFSKit
import Foundation

extension Write {
    struct Create: GraniteReducer {
        typealias Center = Write.Center
        
        func reduce(state: inout Center.State) {
            
            let title = state.title
            let content = state.content.trimmingCharacters(in: .whitespacesAndNewlines)
            let imageData: Data? = nil// state.imageData
            
            let enableIPFS: Bool = true//state.enableIPFS
            let ipfsContentStyle: Int = 0//state.selectedIPFSContentStyle
            _ = Task {
                
                //TODO: html page meta image
//                let image_url: String
//
//                if let imageData {
//                    let response = await IPFS.upload(imageData)
//
//
//                    guard let ipfsURL = IPFSKit.gateway?.genericURL(for: response) else {
//                        image_url = "https://stoic-static-files.s3.us-west-1.amazonaws.com/neatia/neatia.png"
//                        return
//                    }
//                    image_url = ipfsURL.absoluteString
//                } else {
//                    image_url = "https://stoic-static-files.s3.us-west-1.amazonaws.com/neatia/neatia.png"
//                }
                
                var url: String? = nil//image_url
                var subcontent: String = ""
                if enableIPFS {
                    let text: String = Write
                        .Generate
                        .htmlMarkdown(title: title,
                                      author: "pexavc",
                                      //TODO: better occurence sanitizer
                                      content: content.replacingOccurrences(of: "`", with: "\\`"),
                                      //TODO: link your pages at the bottom of the md
                                      urlString: "https://twitter.com/pexavc",
                                      image_url: "https://stoic-static-files.s3.us-west-1.amazonaws.com/neatia/neatia.png")
                    
                    guard let data: Data = text.data(using: .utf8) else {
                        return
                    }
                    
                    let response = await IPFS.upload(data)
                    
                    guard let ipfsURL = IPFSKit.gateway?.genericURL(for: response) else {
                        return
                    }
                    url = ipfsURL.absoluteString
                    subcontent += "\n\n[preserved](\(ipfsURL.absoluteString))"
                }
                
                print("published to: \(url)")
            }
        }
    }
}

