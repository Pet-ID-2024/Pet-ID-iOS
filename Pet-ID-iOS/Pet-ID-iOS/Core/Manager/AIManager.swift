import TensorFlowLite
import UIKit

final class AIManager {
    static let shared = AIManager()
    private var interpreter: Interpreter?
    
    private init() {}
    
    // MARK: - Load Model
    func loadModel(named modelName: String) throws {
        guard let modelPath = Bundle.main.path(forResource: modelName, ofType: "tflite") else {
            throw AIManagerError.modelNotFound
        }
        interpreter = try Interpreter(modelPath: modelPath)
        try interpreter?.allocateTensors()
        Logger().debug("✅ TensorFlow Lite 모델 로드 완료: \(modelName)")
    }
    
    // MARK: - Run Model
    func runModel(with image: UIImage) throws -> [Float] {
        guard let interpreter = interpreter else {
            throw AIManagerError.modelNotInitialized
        }
        
        // 1. 이미지 전처리
        Logger().debug("📡 이미지 전처리 시작")
        let inputData = try preprocessImage(image)
        
        // 2. 입력 데이터 설정
        try interpreter.copy(inputData, toInputAt: 0)
        Logger().debug("✅ 입력 데이터 설정 완료")
        
        // 3. 모델 실행
        try interpreter.invoke()
        Logger().debug("✅ 모델 실행 완료")
        
        // 4. 출력 데이터 가져오기
        let outputTensor = try interpreter.output(at: 0)
        Logger().debug("📊 출력 데이터 크기: \(outputTensor.data.count) 바이트")
        return outputTensor.data.toArray(type: Float.self)
    }
    
    // MARK: - Image Preprocessing
    private func preprocessImage(_ image: UIImage) throws -> Data {
        guard let resizedImage = image.resized(to: CGSize(width: 224, height: 224)),
              let rgbData = resizedImage.rgbData() else {
            throw AIManagerError.preprocessingFailed
        }
        return rgbData
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func rgbData() -> Data? {
        guard let cgImage = self.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 3
        let data = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height * bytesPerPixel)
        defer { data.deallocate() }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: data,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesPerPixel * width,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.none.rawValue)
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return Data(bytes: data, count: width * height * bytesPerPixel)
    }
}

extension Data {
    func toArray<T>(type: T.Type) -> [T] {
        let elementSize = MemoryLayout<T>.size
        let count = self.count / elementSize
        return withUnsafeBytes { buffer in
            Array(buffer.bindMemory(to: T.self))
        }
    }
}

// MARK: - 에러 정의
enum AIManagerError: Error {
    case modelNotFound
    case modelNotInitialized
    case preprocessingFailed
    case invalidOutput
}
