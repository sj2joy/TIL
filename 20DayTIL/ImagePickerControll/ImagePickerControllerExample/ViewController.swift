

import UIKit
import MobileCoreServices

final class ViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction private func pickImage(_ sender: Any) {
        print("\n---------- [ pickImage ] ----------\n")
        
        imagePicker.sourceType = .photoLibrary // 기본값
        //    imagePicker.sourceType = .savedPhotosAlbum -- 포토라이브러리랑 비슷하지만 한단계를 덜 거침(화면에 띄워지는 방식이 다름)
        
        present(imagePicker, animated: true)
    }
    
    
    @IBAction private func takePicture(_ sender: Any) {
        print("\n---------- [ takePicture ] ----------\n")
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return } //카메라 사용가능여부 확인
        
        //카메라 눌렀을 때 사진을 찍을지, 영상을 찍을지 선택하는 메뉴가 생김
        //["public.image"] = 카메라찍는곳 위에 메뉴가 추가로 생김
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)
        imagePicker.mediaTypes = mediaTypes ?? []
        //        imagePicker.mediaTypes = ["public.image"] //이런식으로 바로 특정사진을 넣어놓을 수도 있음
        imagePicker.mediaTypes = [kUTTypeImage,kUTTypeMovie] as [String] //import MobileCoreServices 먼저 해줘야함
        //            imagePicker.mediaTypes = [kUTTypeImage as String] //한개일 때 , 위에는2개이상일 때
        
        //        imagePicker.cameraFlashMode = .auto //카메라 플래시 모드 지정하고 싶을 때 사용
        print(imagePicker.mediaTypes)
        
        //plist가서 카메라 권한승인받아야함 (Privacy camera usage description)
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @IBAction private func takePictureWithDelay(_ sender: Any) {
        print("\n---------- [ takePictureWithDelay ] ----------\n")
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        //plist가서 카메라 권한승인받아야함 (Privacy camera usage description)
        
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeImage as String] //동영상이 아닌 사진지연촬영이므로 kUTTypeImage만
        
        present(imagePicker, animated: true){
            //            self.imagePicker.takePicture() //이렇게만 쓰면 대기없이 바로 찍힘, 내가 원하는 시점에 넣을 수 있다
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:{ // 2초후에 사진이 찍히도록 하는
                self.imagePicker.takePicture()
            })
        }
    }
    
    
    @IBAction private func recordingVideo(_ sender: Any) {
        print("\n---------- [ recordingVideo ] ----------\n")
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeMovie as String] // "public.movie"
        //kuttypemovie와 kuttypevideo의 차이 = movie는 소리포함, video는 영상만 plist 에서 Privacy microphone 승인받아야함
        imagePicker.cameraCaptureMode = .video //캡쳐할 때 뭐로 나오게 할지 지정하는것,여기선 kuttypemovie로 지정해놔서 이건 안써도 되지만 명시적으로 하기위해 씀
        
        imagePicker.cameraDevice = .rear//카메라 화면전환(정면,후면)
        imagePicker.videoQuality = .typeHigh //카메라 화질 올릴 때 
        present(imagePicker, animated:  true)
        
        //동영상 촬영 시작 - 종료 (원하는타이밍에 넣으면 됨)
        //        imagePicker.startVideoCapture()
        //        imagePicker.stopVideoCapture()
        
    }
    
    @IBAction private func toggleAllowsEditing(_ sender: Any) {
        print("\n---------- [ toggleAllowsEditing ] ----------\n")
        imagePicker.allowsEditing.toggle() //editing변경을 누르고 앨범에서 사진을 드래그할 수 있게 됨
        //기본값은 true지만 여기선 toggle로 누를때마다 고정이나 변경되게 바꿀 수 있음
    }
}
//MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
        //cancel메서드에서 할 작업이 없으면 생략
        
        picker.dismiss(animated: true, completion: nil)//화면 닫히게
    }
    
    
    //선택한 사진의 이미지를 센터에 띄울때, 사진이 찍히면 이곳으로 이동하게됨
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("didfinish")
        
        let mediaType = info[.mediaType] as! NSString
        if UTTypeEqual(mediaType, kUTTypeImage){
            //앨범에 있는 사진을 눌렀을 때 그 사진이 메인에 띄워지게하는
            let originalImage = info[.originalImage] as! UIImage
            imageView.image = originalImage
            
            let editedImage = info[.editedImage] as? UIImage //toggleAllowsEditing에서 edit한 사진을 앨범에 그대로 표현되게할때 사용(화면 확대나 축소한걸 그대로 이미지 뷰에 띄울 때) , 없을 수도 있으므로 !가 아닌 ?를 사용
            let selectedImage = editedImage ?? originalImage
            imageView.image = selectedImage
            
            //카메라로 찍고 저장 바로 하는것, plist에서 Privacy - photo library Addion 추가해야함
            //아래if문은 동영상ㅇ 촬영까지 바로 저장되게 하는것
            if picker.sourceType == .camera{
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
            }
        }else if UTTypeEqual(mediaType, kUTTypeMovie) {//영상저장
            if let mediaPath = (info[.mediaURL] as? NSURL)?.path,
                UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaPath){//영상이 저장이 될수있는지 확인여부, 확인되면 아래 내용대로 저장을 함
                UISaveVideoAtPathToSavedPhotosAlbum(mediaPath, nil, nil, nil)
            }
        }
        picker.dismiss(animated: true, completion: nil)//화면 닫히게
    }
}
