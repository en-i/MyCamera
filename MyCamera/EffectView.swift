//
//  EffectView.swift
//  MyCamera
//
//  Created by terada enishi on 2021/07/11.
//

import SwiftUI

let filterArray = ["CIPhotoEffectMono","CIPhotoEffectChrome","CIPhotoEffectFade","CIPhotoEffectInstant","CIPhotoEffectNoir","CIPhotoEffectProcess","CIPhotoEffectTonal","CIPhotoEffectTransfer","CISepiaTone"]

var filterSelectNumber = 0

struct EffectView: View {
    @Binding var isShowSheet: Bool
    
    let caputureImage: UIImage
    
    @State var showImage: UIImage?
    
    @State var isShowActiviry = false
    var body: some View {
        VStack{
            Spacer()
            
            if let unwrapShowImage = showImage{
                Image(uiImage: unwrapShowImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            Button(action: {
               let filterName = filterArray[filterSelectNumber]
                
                filterSelectNumber += 1
                
                if filterSelectNumber == filterArray.count{
                    filterSelectNumber = 0
                }
                
                let rotate = caputureImage.imageOrientation
                
                let inputImage = CIImage(image: caputureImage)
                
                guard let effectFilter = CIFilter(name: filterName)else{
                    return
                }
                
                effectFilter.setDefaults()
                
                effectFilter.setValue(inputImage,forKey: kCIInputImageKey)
                
                guard let outputImage = effectFilter.outputImage else{
                    return
                }
                
                let ciContext = CIContext(options: nil)
                
                guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else{
                    return
                }
                
                showImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
            }) {
                Text("エフェクト")
                    .frame( maxWidth: .infinity)
                    .frame(height: 50.0)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            Button(action: {
                isShowActiviry = true
            }) {
                Text("シェア")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .sheet(isPresented: $isShowActiviry){
                ActivityView(shareItems: [showImage!.resize()!])
            }
            .padding()
            
            Button(action: {
                isShowSheet = false
            }) {
                Text("閉じる")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .padding()
        }
        .onAppear{
            showImage = caputureImage
        }
    }
}

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(isShowSheet: Binding.constant(true), caputureImage: UIImage(named: "preview_use")!)
    }
}



