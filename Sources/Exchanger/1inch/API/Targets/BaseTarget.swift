import Foundation
import Moya

struct DexTarget: TargetType {
    let target: TargetType
    
    var baseURL: URL {
        target.baseURL
    }
    
    var path: String {
        target.path
    }
    
    var method: Moya.Method {
        target.method
    }
    
    var task: Task {
        target.task
    }
    
    var headers: [String : String]? {
        target.headers
    }
}
