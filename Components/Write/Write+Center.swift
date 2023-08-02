import Granite
import SwiftUI

extension Write {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var title: String = ""
            var content: String = ""
            
            /*
            var imageData: Data? = nil
            var postURL: String = ""
            
            var enableIPFS: Bool = false
            
            var selectedIPFSContentStyle: Int = 1
            var ipfsType: [String] = ["Markdown", "Classic"]
             */
        }
        
        @Event(.onAppear) var boot: Write.Boot.Reducer
        @Event var create: Write.Create.Reducer
        
        @Store public var state: State
    }
}
