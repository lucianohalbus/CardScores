//Created by Halbus Development

import SwiftUI
import PhotosUI
import UIKit

struct BuracoMatchView: View {
    var matchFB: BuracoFBViewModel
    @State private var presentAddNewMatchTurnView: Bool = false
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var buracoTurnVM = BuracoTurnsViewModel()
    @StateObject private var storageVM = StorageViewModel()
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var selectedImage: Image? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            
            matchResumeViewHeader
                .padding(.bottom, 5)
            
            ScrollView {
                if !buracoTurnVM.turns.isEmpty {
                    matchResumeViewList
                }
            }
        }
        .padding()
        .onAppear(perform: {
            buracoTurnVM.getTurn()
            buracoListVM.scoreOne = matchFB.finalScoreOne
            buracoListVM.scoreTwo = matchFB.finalScoreTwo
            buracoListVM.gameOver = matchFB.gameOver
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    
                    Spacer()
                    
                    Image(systemName: "camera.fill")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundStyle(Color.cardColor)
                        .onTapGesture { self.shouldPresentActionScheet = true }
                        .sheet(isPresented: $shouldPresentImagePicker) {
                            
                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                                              image: self.$selectedImage,
                                              isPresented: self.$shouldPresentImagePicker
                            )
                        }
                        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                            ActionSheet(title: Text("Choose mode"),
                                        message: Text("Choose a mode to set your profile image"),
                                        buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = true
                            }),
                                                  
                            ActionSheet.Button.default(Text("Photo Library"), action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = false
                            }),
                                                  
                            ActionSheet.Button.cancel()])
                        }
                        .onChange(of: selectedImage) { oldValue, newValue in
                            if let newValue {
                            let uiimage: UIImage = newValue.asUIImage()
                                
                                storageVM.saveMatchImage(userId: "\(buracoListVM.userId)", item: uiimage, matchId: matchFB.id)
                            }
                        }
                    
                        if !buracoListVM.gameOver {
                            
                            Spacer()
                            
                            
                            Button {
                                presentAddNewMatchTurnView.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                                    .bold()
                            }
                            .buttonStyle(.borderless)
                            .padding(.trailing, 20)
                            .tint(Color.cardColor)
                            .sheet(isPresented: $presentAddNewMatchTurnView, content: {
                                
                                AddNewMatchTurnView(matchFB: matchFB)
                                    .interactiveDismissDisabled()
                                    .onDisappear(perform: {
                                        buracoTurnVM.getTurn()
                                        buracoListVM.getMatches()
                                    })
                            })
                            
                            Spacer()
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var matchResumeViewHeader: some View {
        VStack {
            VStack {
                Text(!buracoListVM.gameOver ? "Partida Em Andamento" : "Partida Encerrada")
                    .font(.title3)
                    .foregroundColor(.cardColor)
            }
            
            HStack {
                VStack (alignment: .leading) {
                    Text(matchFB.playerOne)
                    Text(matchFB.playerTwo)
                    Text(buracoListVM.scoreOne)
                        .font(.title3)
                        .foregroundStyle(Int(buracoListVM.scoreOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoListVM.scoreOne) ?? 0 > Int(buracoListVM.scoreTwo) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(matchFB.playerThree)
                    Text(matchFB.playerFour)
                    Text(buracoListVM.scoreTwo)
                        .font(.title3)
                        .foregroundStyle(Int(buracoListVM.scoreTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoListVM.scoreTwo) ?? 0 > Int(buracoListVM.scoreOne) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(15)
            .background(Color.cardBackgroundColor)
            .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    private var matchResumeViewList: some View {
        VStack(spacing: 5) {
            VStack {
                ForEach(buracoTurnVM.turns) { matchResume in
                    if matchResume.turnId == matchFB.id {
                        
                        HStack(spacing: 5) {
                            
                            VStack {
                                Text("\(abs(Int(matchResume.scoresTurnOne) ?? 0))")
                                    .foregroundStyle(Int(matchResume.scoresTurnOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                            }
                            .frame(width: 50, alignment: .leading)
                            
                            Spacer()
                            
                            VStack {
                                Text(matchResume.myTime.formatted(date: .abbreviated, time: .shortened))
                            }
                            .frame(width: 180, alignment: .center)
                            
                            Spacer()
                            
                            VStack {
                                Text("\(abs(Int(matchResume.scoresTurnTwo) ?? 0))")
                                    .foregroundStyle(Int(matchResume.scoresTurnTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                            }
                            .frame(width: 50, alignment: .trailing)
                            
                        }
                        .font(.callout)
                        .padding(.horizontal, 15)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 10)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 2)
                    .stroke(Color.textFieldBorderColor, lineWidth: 2)
            )
            
            if let urlString = matchFB.imagePath, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .clipShape(Rectangle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textViewBackgroundColor, lineWidth: 1))
                        .shadow(radius: 10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 150, height: 150)
                }
            }     
        }
    }
}


extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
 // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
