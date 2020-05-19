

import UIKit
//아이폰 연동해서 해볼것
final class ViewController: UIViewController {
    //시스템 앱
    @IBAction private func openSetting(_ sender: Any) {
        print("\n---------- [ openSettingApp ] ----------\n")
        
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openMail(_ sender: Any) {
        print("\n---------- [ openMail ] ----------\n")
        //    let scheme = "mailto:"
        //    let scheme = "mailto:someone@mail.com,someone2@mail.com,someone3@mail.com" //-> 메일 주소에 적힌 곳으로 전송
        let scheme = "mailto:someone@mail.com?cc=foo@bar.com&subject=title&body=MyText" //cc = 참조 , subject = title , body = text , bcc = 숨은참조
        guard let url = URL(string: scheme),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openMessage(_ sender: Any) {
        print("\n---------- [ openMessage ] ----------\n")
        //    let url = URL(string: "sms:")!
        let url = URL(string: "sms:010-6294-0743&body=Hello")!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openWebsite(_ sender: Any) {
        print("\n---------- [ openWebsite ] ----------\n")
        let url = URL(string: "https://naver.com")!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
        
    }
    
    
    //3rd Party앱 ( 제 3 자)
    
    @IBAction private func openFacebook(_ sender: Any) {
        print("\n---------- [ openFacebook ] ----------\n")
        //페북이 깔려잇어야함, 3rd party앱에 대해서 화이트리스트 등록 필요
        //최소 1회 넘어갈 때 이동을 허락하면 이후부터는 바로 넘어감
        
        //(화이트리스트추가) -> 슬렉에 올라온 코드를 plist에 소스코드 아래쪽(자세한건 가서보면 됨)에 추가
        //infoplist에서 open as -> source code 가서 맨아래쪽에 추가해줘야함
        let url = URL(string: "fb:")!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func openMyApp(_ sender: Any) {
        print("\n---------- [ openMyApp ] ----------\n")
        //myApp://host?name=abc&age=10
        //    scheme: myApp
        //    host: host
        //    query: name=abc&age=10
        //
        //우리가 만든앱을 넣어보는것
//        let url = URL(string: "myApp:")! //그냥 만든앱 가져오기만 할 ㄸ ㅐ
        
        //데이터를 같이 가져오고싶을때 + myapp파일에 appdelegate에서 수정을 해야함
        let url = URL(string: "myApp://host?name=abc&age=10")!
        
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}



