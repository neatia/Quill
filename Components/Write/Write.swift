import Granite
import SwiftUI

struct Write: GraniteComponent {
    @Command var center: Center
    @Relay var modal: ModalService
    
    enum Kind {
        case compact
        case full
    }
    
    var kind: Kind
    
    init(kind: Write.Kind? = nil) {
        if let kind {
            self.kind = kind
        } else {
            #if os(macOS)
            self.kind = .full
            #else
            self.kind = .compact
            #endif
        }
    }
}
