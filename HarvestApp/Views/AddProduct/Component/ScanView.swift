//
//  ScanView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/07/2021.
//

import SwiftUI
import Vision

struct ScanView: View {
    @State private var image : Image?
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showingImagePicker = true
            }, label: {
                if image != nil {
                    image?
                        .resizable()
                        .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "camera.fill")
                        .foregroundColor(.black)
                        .padding(40)
                        .background(Color.gray.opacity(0.5))
                        .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                }
            })
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            VStack {
                ImagePicker(image: $inputImage)
            }
        })
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
//    let request = VNRecognizeTextRequest { request, error in
//        guard let observations = request.results as? [VNRecognizedTextObservation] else {
//            fatalError("Received invalid observations")
//        }
//
//        for observation in observations {
//            guard let bestCandidate = observation.topCandidates(1).first else {
//                print("No candidate")
//                continue
//            }
//
//            print("Found this candidate: \(bestCandidate.string)")
//        }
//    }
//    let requests = [request]
//
//    DispatchQueue.global(qos: .userInitiated).async {
//        guard let img = UIImage(named: "testImage")?.cgImage else {
//            fatalError("Missing image to scan")
//        }
//
//        let handler = VNImageRequestHandler(cgImage: img, options: [:])
//        try? handler.perform(requests)
//    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
