import Moya

enum ReservationListAPI: BaseTargetType {
    case createReservation(hospitalId: Int, date: String)
    case updateReservation(orderId: Int, date: String)
    case cancelReservation(orderId: Int)
    case fetchReservations(status: String)

    var path: String {
        switch self {
        case .createReservation:
            return "/v1/hospital/order"
        case .updateReservation:
            return "/v1/hospital/order"
        case .cancelReservation(let orderId):
            return "/v1/hospital/order/\(orderId)"
        case .fetchReservations:
            return "/v1/hospital/order"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createReservation:
            return .post
        case .updateReservation:
            return .patch
        case .cancelReservation:
            return .delete
        case .fetchReservations:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .createReservation(let hospitalId, let date):
            let parameters: [String: Any] = [
                "hospitalId": hospitalId,
                "date": date
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updateReservation(let orderId, let date):
            let parameters: [String: Any] = [
                "orderId": orderId,
                "date": date
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .cancelReservation:
            return .requestPlain
            
        case .fetchReservations(let status):
            let parameters: [String: Any] = [
                "status": status
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
