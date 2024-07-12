//import SwiftUI
//import TensorFlowLite
//
//struct Test: View {
//    @State private var prediction: [Float] = []
//
//    var body: some View {
//        VStack {
//            if let uiImage = UIImage(named: "gang1") {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 640, height: 640)
//            } else {
//                Text("Failed to load image.")
//            }
//
//            Button(action: {
//                self.runModel()
//            }) {
//                Text("Predict")
//            }
//
//            if !prediction.isEmpty {
//                Text("Prediction: \(prediction.map { String(format: "%.2f", $0) }.joined(separator: ", "))")
//                    .padding()
//            }
//        }
//        .padding()
//    }
//
//    private func runModel() {
//        guard let uiImage = UIImage(named: "gang1") else {
//            print("Failed to load image.")
//            return
//        }
//        
//        
//
//        guard let modelPath = Bundle.main.path(forResource: "model", ofType: "tflite") else {
//            print("Failed to find model file.")
//            return
//        }
//
//        do {
//            var options = Interpreter.Options()
//            options.threadCount = 2
//            let interpreter = try Interpreter(modelPath: modelPath, options: options)
//            try interpreter.allocateTensors()
//
//            let inputTensor = try interpreter.input(at: 0)
//            let inputSize = inputTensor.shape.dimensions
//            let inputWidth = inputSize[1]
//            let inputHeight = inputSize[2]
//            let inputChannels = inputSize[3]
//
//            print("Model expects input of size \(inputSize)")
//
//            guard let pixelBuffer = uiImage.pixelBuffer(width: inputWidth, height: inputHeight) else {
//                print("Failed to convert image to pixel buffer.")
//                return
//            }
//            
//            
//
//            guard let inputData = pixelBuffer.toData(channels: inputChannels) else {
//                print("Failed to convert pixel buffer to data.")
//                return
//            }
//
//            print("Converted image to data of size \(inputData.count)")
//
//            if inputData.count != inputTensor.data.count {
//                print("Input data size \(inputData.count) does not match expected size \(inputTensor.data.count).")
//                return
//            }
//
//            try interpreter.copy(inputData, toInputAt: 0)
//            try interpreter.invoke()
//
//            let outputTensor = try interpreter.output(at: 0)
//            let results: [Float] = [Float](unsafeData: outputTensor.data) ?? []
//
//            DispatchQueue.main.async {
//                self.prediction = results
//            }
//        } catch {
//            print("Failed to run model: \(error)")
//        }
//    }
//}
//
//// UIImage를 CVPixelBuffer로 변환하는 확장
//extension UIImage {
//    func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
//        let pixelFormatType = kCVPixelFormatType_32BGRA
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)
//
//        let attributes: [NSObject: Any] = [
//            kCVPixelBufferCGImageCompatibilityKey: true,
//            kCVPixelBufferCGBitmapContextCompatibilityKey: true
//        ]
//        var pixelBuffer: CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                         width,
//                                         height,
//                                         pixelFormatType,
//                                         attributes as CFDictionary,
//                                         &pixelBuffer)
//        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
//            return nil
//        }
//
//        CVPixelBufferLockBaseAddress(buffer, [])
//        let pixelData = CVPixelBufferGetBaseAddress(buffer)
//
//        guard let cgImage = self.cgImage else {
//            return nil
//        }
//
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//        guard let context = CGContext(data: pixelData,
//                                      width: width,
//                                      height: height,
//                                      bitsPerComponent: 8,
//                                      bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
//                                      space: rgbColorSpace,
//                                      bitmapInfo: bitmapInfo.rawValue) else {
//            return nil
//        }
//
//        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//
//        CVPixelBufferUnlockBaseAddress(buffer, [])
//
//        return buffer
//    }
//}
//
//// CVPixelBuffer를 Data로 변환하는 확장
//extension CVPixelBuffer {
//    func toData(channels: Int) -> Data? {
//        CVPixelBufferLockBaseAddress(self, .readOnly)
//        defer { CVPixelBufferUnlockBaseAddress(self, .readOnly) }
//
//        let width = CVPixelBufferGetWidth(self)
//        let height = CVPixelBufferGetHeight(self)
//        let bytesPerRow = CVPixelBufferGetBytesPerRow(self)
//
//        guard let baseAddress = CVPixelBufferGetBaseAddress(self) else {
//            return nil
//        }
//
//        let data = Data(bytes: baseAddress, count: height * bytesPerRow)
//        return data
//    }
//}
//
//
//
//
//
//
//// TensorFlow Lite 출력을 배열로 변환하는 확장
//extension Array {
//    init?(unsafeData: Data) {
//        guard unsafeData.count % MemoryLayout<Element>.stride == 0 else { return nil }
//        self = unsafeData.withUnsafeBytes {
//            Array(UnsafeBufferPointer<Element>(start: $0.baseAddress!.assumingMemoryBound(to: Element.self), count: unsafeData.count / MemoryLayout<Element>.stride))
//        }
//    }
//}
//
//#Preview {
//    Test()
//}
