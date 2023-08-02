import Granite
import IPFSKit
import Foundation

extension Write {
    struct Boot: GraniteReducer {
        typealias Center = Write.Center
        
        func reduce(state: inout Center.State) {
            IPFSKit.gateway = InfuraGateway()
        }
    }
}

struct InfuraGateway: IPFSGateway {
    var host: IPFSHost {
        InfuraHost(id: "",//On Infura, this is simply the API_KEY
                   secret: "")//API_KEY_SECRET
    }
    
    var gateway: String {
        ""
    }
}
