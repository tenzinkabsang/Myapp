import SwiftUI
import Resolver
import Combine
import Firebase


protocol IImageService {
    func saveImage(image: UIImage, imageName : String?, userCompletionHandler: @escaping (String) -> Void)
}

class ImageService : IImageService {
    private let PATH : String = "profile/"
    
    func saveImage(image: UIImage, imageName: String?, userCompletionHandler: @escaping (String) -> Void) {
        let resizedImage = image.aspectFittedToHeight(150)
        guard let imageData = resizedImage.jpegData(compressionQuality: 0.5) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let imagePath = PATH + "\(imageName ?? UUID().uuidString)"
        
        let ref = FirebaseManager.shared.storage.reference(withPath: imagePath)
        
        ref.putData(imageData, metadata: metadata) { metadata, err in
            if let err = err {
                print("failed to save image: \(err)")
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrieve downloadURL: \(err)")
                    return
                }
                
                guard let imgUrl = url?.absoluteString else {
                    print ("Unable to get image url")
                    return
                }
                
                print("Returned Image path: \(imgUrl)")
                
                userCompletionHandler(imgUrl)
                
            }
        }
        
    }
}


class ProfileViewModel : ObservableObject {
    @Injected var imageService: IImageService
    
    @Published var selectedImage = UIImage()
    
    @Published var uploadInProgress: Bool = false
    
    
    func uploadProfileImage(userAccountVM: UserAccountViewModel, img: UIImage) {
        uploadInProgress = true
        
        imageService.saveImage(image: img, imageName: userAccountVM.userId, userCompletionHandler: { imgUrl in
            print("Updating user in database")
            
            userAccountVM.updateUser(profileImgUrl: imgUrl)
            
            self.uploadInProgress = false
        })
    }
}

struct ProfileView: View {
    @EnvironmentObject private var userAccountVM : UserAccountViewModel
    @ObservedObject var profileVM = ProfileViewModel()
    
    @State var showImagePicker = false
    var imageUrl: String?
    
    init() {
        self.imageUrl = userAccountVM.profileImageUrl
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            profileImage
            
            Spacer()
        }
        .toolbar {
            Button {
                print("saving...")
            } label : {
                Text("SAVE")
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder var profileImage : some View {
        HStack(alignment: .center) {
            
            ZStack(alignment: .bottomTrailing) {
                
                Button {
                    showImagePicker.toggle()
                } label: {
                    
                    if !profileVM.uploadInProgress {
                        
                        CardProfileImage(imageUrl: imageUrl ?? "",
                                         imageSize: 120,
                                         image: imageUrl.isNilOrEmpty() ? Image("person") : nil)
                    } else {
                        CardProfileImage(imageUrl: "", imageSize: 120, image: Image(uiImage: profileVM.selectedImage))
                    }
                }
                
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .background(.gray)
                    .clipShape(Circle())
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profileVM.selectedImage)
                    .onChange(of: profileVM.selectedImage) { newValue in
                        profileVM.uploadProfileImage(userAccountVM: userAccountVM, img: newValue)
                    }
            }
        }
        .padding()
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
