import Moya

enum MemberAPI {
    case saveMember(name: String, address: String, phone: String, receiveAgreement: Bool)
}

extension MemberAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://yourpet-id.com:8080")!
    }
    
    var path: String {
        switch self {
        case .saveMember:
            return "/v1/member/auth"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .saveMember:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .saveMember(name, address, phone, receiveAgreement):
            let parameters: [String: Any] = [
                "name": name,
                "address": address,
                "phone": phone,
                "receiveAgreement": receiveAgreement
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
//    var headers: [String: String]? {
//            do {
//                let authorization: Authorization = try DefaultAuthRepository().fetchAuthTokensFromKeychainSync()
//                print("Fetched access token: \(authorization.accessToken)")
//                return ["Authorization": "Bearer \(authorization.accessToken)",
//                "Content-Type": "application/json"]
//            } catch {
//                print("Error fetching access token: \(error)")
//                return nil
//            }
//        }
    var headers: [String: String]? {
        return ["Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwicm9sZSI6IlJPTEVfVVNFUiIsImV4cCI6MTcyODA1ODMxOCwidG9rZW5UeXBlIjoiUkVGUkVTSF9UT0tFTiJ9.NmQsgV1b8NoMWM1MkG27eEchxt8Fhd3bb0RQOXmkp2s"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var sampleData: Data {
        return Data()
    }
}

//struct SaveMemberResponse: Codable {
//    let name: String
//    let address: String
//    let phone: String
//}

struct SaveMemberRequest: Encodable {
    let name: String
    let address: String
    let phone: String
    let receiveAgreement: Bool
}

struct SaveMemberResponse: Decodable {
    let name: String
    let address: String
    let phone: String
}
